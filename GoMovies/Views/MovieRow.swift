//
//  MovieRow.swift
//  GoMovies
//
//  Created by Ashish Karna on 15/07/2025.
//

import SwiftUI

struct MovieRow: View {
    let movie: Movie
    var body: some View {
        HStack(alignment: .top) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 60, height: 90)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 90)
                            .clipped()
                            .cornerRadius(6)
                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: 60, height: 90)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .frame(width: 60, height: 90)
            }
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text("Release: \(movie.releaseDate ?? "n/a")")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    MovieRow(movie: Movie.staticData)
}
