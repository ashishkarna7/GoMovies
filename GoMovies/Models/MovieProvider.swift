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
    private(set) var isSearching = false
    private(set) var isFetchingDetail = false
    private(set) var favoriteMovies: [Movie] = []
    
    var error: MovieError?
    var isErrorActive = false
    var selectedMovie: Movie?
    
    private(set) var currentQuery: String = ""
    private(set) var currentPage: Int = 1
    private(set) var totalPages: Int = 1
    
    var favoriteData: [String: Bool] = [:]
    
    private let keyFavorite = "key_favorite"
    
    private let client: MovieClient
    
    init(client: MovieClient = MovieClient()) {
        self.client = client
        loadFavorites() 
    }
    
    func searchMovie(query: String) async {
        
        if currentQuery != query {
            reset()
            currentQuery = query
        }
        
        guard !isSearching, currentPage <= totalPages else { return }
        
        isSearching = true
        defer {
            isSearching = false
        }
        
        clearError()
        
        do {
            let result = try await client.searchMovie(query: currentQuery, page: currentPage)
            movies.append(contentsOf: result.results)
            totalPages = result.totalPages
            currentPage += 1
        } catch {
            self.error = error as? MovieError ?? .unexpectedError(error: error)
            isErrorActive = true
        }
        
    }
    
    func reset() {
        movies = []
        currentPage = 1
        totalPages = 1
    }
    
    func clearError() {
        isErrorActive = false
        error = nil
    }

    
    func getMovieDetail(movieId: Int) async {
        isFetchingDetail = true
        defer {
            isFetchingDetail = false
        }
        clearError()
        
        do {
            let fetchedMovie = try await client.movie(id: movieId)
            self.selectedMovie = fetchedMovie
        } catch {
            self.error = error as? MovieError ?? .unexpectedError(error: error)
            self.isErrorActive = true
        }
    }
    
    
    func isFavorite(movieId: Int) -> Bool {
        return favoriteData["\(movieId)"] ?? false
    }
    
    func toggleFavorite(movieId: Int) {
        favoriteData["\(movieId)"] = isFavorite(movieId: movieId)
        favoriteData["\(movieId)"]?.toggle()
        saveFavorites()
    }
    
    func saveFavorites() {
        UserDefaults.standard.setValue(favoriteData, forKey: keyFavorite)
        UserDefaults.standard.synchronize()
        loadFavorites()
    }
    
    func loadFavorites() {
        favoriteData = UserDefaults.standard.value(forKey: keyFavorite) as? [String: Bool] ?? [:]
        self.favoriteMovies = movies.filter({ isFavorite(movieId: $0.id) })
    }
}
