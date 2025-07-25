//
//  FavoritesView.swift
//  GoMovies
//
//  Created by Ashish Karna on 17/07/2025.
//

import SwiftUI
import _SwiftData_SwiftUI

struct FavoritesView: View {
    @Environment(FavoritesManager.self) var favoriteManager
    
    @State private var viewModel = FavoritesViewModel()
    
    @State private var selection: Set<String> = []
    @Query(sort:\Movie.title) var savedMovies: [Movie]
    
    var body: some View {
        VStack {
            if viewModel.movies.isEmpty {
                if let movies = getSavedFavoriteMovies(), !movies.isEmpty {
                    listContent(movies: movies)
                } else {
                    Text("No result found")
                }
            }else {
                listContent(movies: viewModel.movies)
            }
        }
        .navigationTitle("Favorite Movies")
    }
    
    func getSavedFavoriteMovies() -> [Movie]? {
        let favoriteMovies = savedMovies.filter({ favoriteManager.isFavorite(movieId: $0.movieId)})
        return favoriteMovies
    }
    
    @ViewBuilder
    func listContent(movies: [Movie]) -> some View {
        List {
            Section("Movies") {
                ForEach(movies) { movie in
                    NavigationLink(destination: {
                        MovieDetailView(movieId: movie.movieId)
                    }, label: {
                        MovieRow(movie: movie)
                    })
                }
            }
        }
    }
    
}

#Preview(traits: .movieSampleData) {
    FavoritesView()
        .environment(FavoritesManager())
}
