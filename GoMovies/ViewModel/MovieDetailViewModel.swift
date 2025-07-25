//
//  MovieDetailViewModel.swift
//  GoMovies
//
//  Created by Ashish Karna on 19/07/2025.
//

import Foundation

class MovieDetailViewModel: BaseViewModel {
    
    private(set) var movieDetail: MovieDetail?
    
    func getMovieDetail(movieId: Int) async {

        isLoading = true
        error = nil
        
        do {
            let fetchedMovie = try await client.movie(id: movieId)
            self.movieDetail = fetchedMovie
        } catch {
            self.error = error as? MovieError ?? .unexpectedError(error: error)
        }
        isLoading = false
    }
}
