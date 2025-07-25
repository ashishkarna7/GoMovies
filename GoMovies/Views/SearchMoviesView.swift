//
//  Movies.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import SwiftUI
import _SwiftData_SwiftUI

struct SearchMoviesView: View {
    @State var viewModel = SearchMovieViewModel()
    @State private var searchText = ""
    
    @Query(sort: \Movie.title) var savedMovies: [Movie]
    
    @Environment(\.modelContext) private var context
    
    @Environment(FavoritesManager.self) var favoriteManger

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView("Searching..")
                    .frame(maxWidth: .infinity)
                    .padding()
            } else if viewModel.movies.isEmpty, !savedMovies.isEmpty {
                listContent(movies: savedMovies)
            }else {
                listContent(movies: viewModel.movies)
            }
        }
        .navigationTitle("Search Movies")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .alert("Error", isPresented: .constant(viewModel.error != nil), actions: {
            Button("Ok", role: .cancel, action: {
                viewModel.error = nil
            })
        }, message: {
            Text(viewModel.error?.errorDescription ?? "")
        })
        .task(id: searchText) {
            guard !searchText.isEmpty else { return }
            do {
                try await Task.sleep(for: .seconds(0.5))
                await loadMovies()
            } catch {
                print("Search was cancelled")
            }
        }
        .refreshable {
            viewModel.reset()
            await loadMovies()
        }
    }
    
    @ViewBuilder
    func listContent(movies: [Movie]) -> some View {
        List {
            Section(content: {
                ForEach(movies, id: \.persistentModelID) { movie in
                    NavigationLink(destination: MovieDetailView(movieId: movie.movieId)) {
                        MovieRow(movie: movie)
                    }
                    .onAppear {
                        Task {
                            await loadNextPage(movie: movie)
                        }
                        
                    }
                }
            }, header: {
                Text("Search results")
                    .font(.headline)
                    .textCase(nil)
                    .listRowInsets(EdgeInsets())
            }, footer: {
                if !viewModel.movies.isEmpty, viewModel.isFetchingNextPage {
                    ProgressView("Loading More..")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            })
        }
    }
    
    func loadNextPage(movie: Movie) async {
        if movie.movieId == viewModel.movies.last?.movieId {
            await loadMovies()
        }
    }
    
    private func saveMovies() {
        if viewModel.currentPage == 2 {
            // reset
            for movie in savedMovies {
                if !favoriteManger.isFavorite(movieId: movie.movieId) {
                    context.delete(movie)
                }
            }
            
            // add newly fetch data
            viewModel.movies.forEach({ context.insert($0)})
            
            do {
                try context.save() 
            } catch {
                print("Failed to save movies: \(error)")
            }
        }
    }
    
    func loadMovies() async {
        await viewModel.searchMovie(query: searchText)
        saveMovies()
    }
    
}

#Preview(traits: .movieSampleData) {
    SearchMoviesView()
        .environment(FavoritesManager())
}
