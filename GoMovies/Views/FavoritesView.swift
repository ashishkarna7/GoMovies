//
//  FavoritesView.swift
//  GoMovies
//
//  Created by Ashish Karna on 17/07/2025.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(MovieProvider.self) var provider
    @State private var selection: Set<String> = []
    
    var body: some View {
        VStack {
            if provider.favoriteMovies.isEmpty {
                Text("No result found")
            } else {
                List(selection: $selection) {
                    Section("Movies") {
                        ForEach(provider.favoriteMovies) { movie in
                            NavigationLink(destination: {
                                MovieDetailView(movieId: movie.id)
                            }, label: {
                                MovieRow(movie: movie)
                            })
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorite Movies")
        .task {
            provider.loadFavorites()
        }
    }
    
}

#Preview {
    let client = MovieClient(downloader: TestDownloader())
    let provider = MovieProvider(client: client)
    let view = FavoritesView()
        .environment(provider)
    return view
}
