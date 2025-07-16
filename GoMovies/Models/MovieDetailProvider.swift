//
//  MovieDetailProvider.swift
//  GoMovies
//
//  Created by Ashish Karna on 16/07/2025.
//

import Foundation
import Observation

@Observable
class MovieDetailProvider {
    private let client: MovieClient
    private let movieId: Int
    
    var movie: Movie?
    var isLoading = false
    var error: MovieError?
    
    init(client: MovieClient = MovieClient(), movieId: Int) {
        self.client = client
        self.movieId = movieId
    }
    
    func load() async {
        isLoading = true
        error = nil
        
        do {
            let fetchedMovie = try await client.movie(id: movieId)
            self.movie = fetchedMovie
        } catch {
            self.error = error as? MovieError ?? .unexpectedError(error: error)
        }
        isLoading = false
    }
}
