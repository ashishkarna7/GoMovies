//
//  MovieRow.swift
//  GoMovies
//
//  Created by Ashish Karna on 15/07/2025.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    @Environment(MovieProvider.self) var provider
    
    var body: some View {
        HStack(alignment: .top) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
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
            
            FavoriteButton(isFavorite: provider.isFavorite(movieId: movie.id)) {
                provider.toggleFavorite(movieId: movie.id)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    let provider = MovieProvider(client: MovieClient(downloader: TestDownloader()))
    MovieRow(movie: Movie.example)
        .environment(provider)
}
