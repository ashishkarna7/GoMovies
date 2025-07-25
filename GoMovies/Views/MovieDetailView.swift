//
//  MovieDetailView.swift
//  GoMovies
//
//  Created by Ashish Karna on 16/07/2025.
//

import SwiftUI
import _SwiftData_SwiftUI

struct MovieDetailView: View {
    @Environment(FavoritesManager.self) var favoriteManager
    
    @State private var viewModel = MovieDetailViewModel()
    @State var movieId: Int
    
    @Query(sort: \Movie.title) var savedMovies: [Movie]
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            if viewModel.isLoading, viewModel.movieDetail == nil {
                ProgressView("Loading...")
            } else if let movie = getMovie(movieId: movieId) {
                detailView(movie: movie)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavoriteButton(isFavorite: favoriteManager.isFavorite(movieId: movieId)) {
                    favoriteManager.toggleFavorite(movieId: movieId)
                    if favoriteManager.isFavorite(movieId: movieId) {
                        if let detail = viewModel.movieDetail {
                            if let _ = savedMovies.first(where: { $0.movieId == movieId}) {
                                // do nothing
                            } else{
                                context.insert(detail.toMovie()) // add data in in-memory only
                                try? context.save() // inorder to persist
                            }
                        }
                    }
                }
            }
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil), actions: {
            Button("Ok", role: .cancel) {
                viewModel.error = nil
            }
        }, message: {
            Text(viewModel.error?.errorDescription ?? "")
        })
        .navigationTitle("Movie Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await fetchMovieDetail()
        }
        .refreshable {
            await fetchMovieDetail()
        }
    }
    
    @ViewBuilder
    func detailView(movie: MovieDetail) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let url = movie.smallPosterUrl ?? movie.posterDetailURL {
                    CachedAsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            EmptyImageView()
                                .overlay {
                                    ProgressView()
                                }
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 500)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .background(.gray.opacity(0.3))
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
                    
                    if let tagline = movie.tagline, !tagline.isEmpty {
                        Text("\(tagline)")
                            .italic()
                            .foregroundStyle(.secondary)
                    }
                
                    Text("Released: \(movie.releaseDate ?? "")")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                    if let runTime = movie.runTime {
                        Text("Runtime: \(runTime) min")
                            .font(.subheadline)
                    }
                    
                    if let voteAverage = movie.voteAverage {
                        Text("Rating : \(String(format: "%.1f", voteAverage))/10")
                            .font(.subheadline)
                    }
                    
                    if let genre = movie.genre {
                        Text("Genre: \(genre.map(\.name).joined(separator: ","))")
                            .font(.subheadline)
                    }
                    
                    if let homePage = movie.homePage, let url = URL(string: homePage) {
                        Link("Visit home page", destination: url)
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                            .underline()
                    }
                    
                    Divider()
                    
                    Text("Overview")
                        .font(.headline)
                    
                    Text(movie.overview ?? "No overview available")
                        .font(.body)
                }
                .padding(.horizontal)
            }
        }
    }
    
    func fetchMovieDetail() async {
        await viewModel.getMovieDetail(movieId: movieId)
    }
    
    func getMovie(movieId: Int) -> MovieDetail? {
        if let detail = viewModel.movieDetail {
            return detail
        } else if let item = savedMovies.first(where: { $0.movieId == movieId}) {
            return item.toMovieDetail()
        }
        return nil
    }
}

#Preview(traits: .movieSampleData) {
    @Previewable @Query(sort: \Movie.title) var movies: [Movie]
    MovieDetailView(movieId: movies[0].movieId)
        .environment(FavoritesManager())
}

