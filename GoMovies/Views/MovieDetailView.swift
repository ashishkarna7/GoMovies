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
                                    Rectangle()
                                        .fill(.gray.opacity(0.3))
                                        .frame(height: 300)
                                        .overlay {
                                            ProgressView()
                                        }
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFill()
                                case .failure:
                                    Rectangle()
                                        .fill(.gray.opacity(0.3))
                                        .frame(height: 300)
                                        .overlay {
                                            Image(systemName: "photo.fill")
                                                .font(.largeTitle)
                                                .foregroundStyle(.white)
                                        }
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                                .frame(height: 300)
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
    let client = MovieClient(downloader: TestDownloader())
    let provider = MovieProvider(client: client)
    provider.selectedMovie = Movie.staticData
    let view = MovieDetailView(movieId: Movie.staticData.id)
        .environment(provider)
    return view
}


