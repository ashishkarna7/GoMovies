//
//  MovieDetailView.swift
//  GoMovies
//
//  Created by Ashish Karna on 16/07/2025.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(MovieProvider.self) var provider
    @State var movieId: Int
    
    var body: some View {
        VStack {
            if provider.isFetchingDetail {
                ProgressView("Loading...")
            } else if let movie = provider.selectedMovie {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        if let url = movie.posterDetailURL {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    EmptyImageView()
                                        .overlay {
                                            ProgressView()
                                        }
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFill()
                                default:
                                    EmptyImageView()
                                }
                            }
                        } else {
                            EmptyImageView()
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title)
                                .font(.title)
                                .bold()
                            
                            Text("Released: \(movie.releaseDate ?? "")")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            Divider()
                            
                            Text(movie.overview ?? "No overview available")
                                .font(.body)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .overlay(alignment: .bottom) {
            if let error = provider.error {
                ErrorView(error: error)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavoriteButton(isFavorite: provider.isFavorite(movieId: movieId)) {
                    provider.toggleFavorite(movieId: movieId)
                }
            }
        }
        .onChange(of: provider.isErrorActive) {_, newValue in
            if newValue {
                Task {
                    try? await Task.sleep(for: .seconds(1))
                    withAnimation {
                        provider.clearError()
                    }
                }
            }
        }
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await fetchMovieDetail()
        }
        .refreshable {
            await fetchMovieDetail()
        }
    }
    
    func fetchMovieDetail() async {
        await provider.getMovieDetail(movieId: movieId)
    }
}

#Preview {
    let client = MovieClient(downloader: DetailTestDownloader())
    let provider = MovieProvider(client: client)

    let view = MovieDetailView(movieId: Movie.example.id)
                            .environment(provider)

    return view
}


