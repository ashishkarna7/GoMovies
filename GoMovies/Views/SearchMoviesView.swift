//
//  Movies.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import SwiftUI

struct SearchMoviesView: View {
    @Environment(MovieProvider.self) var provider
    @State private var searchText = ""
    
    @State private var selection: Set<String> = []
    
    var body: some View {
        VStack {
            if provider.isSearching, provider.movies.isEmpty {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                List(selection: $selection) {
                    Section("Movies") {
                        ForEach(provider.movies) { movie in
                            NavigationLink(destination: {
                                MovieDetailView(movieId: movie.id)
                            }, label: {
                                MovieRow(movie: movie)
                            })
                        }
                        
                        if !provider.movies.isEmpty,
                            provider.currentPage <= provider.totalPages {
                            Color.clear
                                .frame(height: 1)
                                .onAppear {
                                    Task {
                                        await provider.searchMovie(query: searchText)
                                    }
                                }
                        }
                    }
                }
            }
        }
        .overlay(alignment: .bottom) {
            if let error = provider.error {
                ErrorView(error: error)
            } else if provider.isSearching, !provider.movies.isEmpty {
                ProgressView()
                    .padding()
                    .background(.thinMaterial, in: Capsule())
                    .padding(.bottom)
            }
        }
        .navigationTitle("Search Movies")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) {(_,newValue) in
            Task {
                await provider.searchMovie(query: newValue)
            }
        }
        .onChange(of: provider.isErrorActive) { _, newValue in
            if newValue {
                Task {
                    try await Task.sleep(for: .seconds(1))
                    withAnimation {
                        provider.clearError()
                    }
                }
            }
        }
        .refreshable {
            Task {
                await provider.searchMovie(query: searchText)
            }
        }
    }
    
}

#Preview {
    let client = MovieClient(downloader: TestDownloader())
    let provider = MovieProvider(client: client)
    let view = SearchMoviesView()
        .environment(provider)
    Task {
        await provider.searchMovie(query: "a")
    }
    
    return view
}
