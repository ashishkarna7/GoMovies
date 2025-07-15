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
    
    var movies: [Movie] = []
    var
    isLoading = false
    var error: MovieError?
    
    var currentQuery: String = ""
    var currentPage: Int = 1
    var totalPages: Int = 1
    
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
        
        guard !isLoading, currentPage <= totalPages else { return }
        
        isLoading = true
        error = nil
        
        do {
            let result = try await client.searchMovie(query: currentQuery, page: currentPage)
            movies.append(contentsOf: result.results)
            totalPages = result.totalPages
            currentPage += 1
            isLoading = false
        } catch {
            isLoading = false
            self.error = error as? MovieError ?? .unexpectedError(error: error)
        }
    }
    
    func reset() {
        movies = []
        currentPage = 1
        totalPages = 1
    }
}
