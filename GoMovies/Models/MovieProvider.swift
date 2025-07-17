//
//  MovieProvider.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation
import Observation

@Observable
class MovieProvider {
    
    private(set) var movies: [Movie] = []
//    var isLoading = false
    private(set) var error: MovieError?
    private(set) var selectedMovie: Movie?
    
    private var currentQuery: String = ""
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
    private let client: MovieClient
    
    init(client: MovieClient = MovieClient()) {
        self.client = client
    }
    
    func searchMovie(query: String) async {
        guard !query.isEmpty else {
//            reset()
            return
        }
        
        if currentQuery != query {
            reset()
            currentQuery = query
        }
        
        guard currentPage <= totalPages else { return }
    
        error = nil
        
        do {
            let result = try await client.searchMovie(query: currentQuery, page: currentPage)
            movies.append(contentsOf: result.results)
            totalPages = result.totalPages
            currentPage += 1
        } catch {
            self.error = error as? MovieError ?? .unexpectedError(error: error)
        }
    }
    
    func reset() {
        movies = []
        currentPage = 1
        totalPages = 1
    }
    
    func setSelectedMovie(movie: Movie) {
        self.selectedMovie = movie
    }
    
    func getMovieDetail(movieId: Int) async {
        self.selectedMovie = movies.first(where: {$0.id == movieId })
        guard let selectedMovie else { return }
        error = nil
        
        do {
            let fetchedMovie = try await client.movie(id: selectedMovie.id)
            self.selectedMovie = fetchedMovie
        } catch {
            self.error = error as? MovieError ?? .unexpectedError(error: error)
        }
    }

}
