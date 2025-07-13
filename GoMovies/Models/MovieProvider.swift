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
    
    private let client: MovieClient
    
    init(client: MovieClient = MovieClient()) {
        self.client = client
    }
    
    func fetchMovies() async throws {
        let latestMovies = try await client.movies
        self.movies = latestMovies
    }
}
