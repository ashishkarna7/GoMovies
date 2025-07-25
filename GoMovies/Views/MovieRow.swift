//
//  MovieRow.swift
//  GoMovies
//
//  Created by Ashish Karna on 15/07/2025.
//

import SwiftUI
import _SwiftData_SwiftUI

struct MovieRow: View {
    let movie: Movie
    @Environment(FavoritesManager.self) var favoriteManager
    @Query(sort: \Movie.title) var savedMovies: [Movie]
    @Environment(\.modelContext) var context
    
    var body: some View {
        HStack(alignment: .top) {
            if let url = movie.posterUrl {
                CachedAsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        EmptySmallImageView()
                            .overlay {
                                ProgressView()
                            }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 90)
                            .clipped()
                            .cornerRadius(6)
                    default:
                        EmptySmallImageView()
                    }
                }
            } else {
                EmptySmallImageView()
            }
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text("Release: \(movie.releaseDate ?? "n/a")")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
            }
            
            Spacer()
            
            FavoriteButton(isFavorite: favoriteManager.isFavorite(movieId: movie.movieId)) {
                favoriteManager.toggleFavorite(movieId: movie.movieId)
                if favoriteManager.isFavorite(movieId: movie.movieId) {
                    if let _ = savedMovies.first(where: { $0.movieId == movie.movieId}) {
                        // do nothing
                    } else {
                        context.insert(movie) // add data in in-memory only
                        try? context.save() // inorder to persist
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview(traits: .movieSampleData) {
    @Previewable @Query(sort: \Movie.title) var movies: [Movie]
    
    MovieRow(movie: movies[0])
        .environment(FavoritesManager())
}

