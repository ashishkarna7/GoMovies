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
            if provider.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if let error = provider.error {
                Text(error.errorDescription ?? "")
            } else {
                List(selection: $selection) {
                    Section("Movies") {
                        ForEach(provider.movies) { movie in
                            NavigationLink(destination: {
                                Text("Item at \(movie.title)")
                            }, label: {
                                MovieRow(movie: movie)
                            })
                        }
                    }
                }
            }
        }
        .navigationTitle("Search Movies")
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchText) {(_,newValue) in
            Task {
                await provider.searchMovie(query: newValue)
            }
        }
        .refreshable {
            Task {
                await provider.searchMovie(query: searchText)
            }
        }
    }
    
    func fetchMovies() async {
         await provider.searchMovie(query: "a")
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
