//
//  SearchMovieViewModel.swift
//  GoMovies
//
//  Created by Ashish Karna on 18/07/2025.
//

import Foundation

class SearchMovieViewModel: BaseViewModel {
    
    private(set) var movies: [Movie] = []
    
    private(set) var debouncedSearchText: String = ""
    private(set) var currentPage: Int = 1
    private(set) var totalPages: Int = 1
    private(set) var isFetchingNextPage = false

    func searchMovie(query: String) async {
        guard !isLoading, !isFetchingNextPage, currentPage <= totalPages else { return }
        if currentPage > 1 {
            isFetchingNextPage = true
        } else {
            isLoading = true
        }
        
        if debouncedSearchText != query {
            reset()
            debouncedSearchText = query
        }
        
        error = nil
        
        do {
            let result = try await client.searchMovie(query: debouncedSearchText, page: currentPage)
            let newMovies = result.results.map { $0.toMovie() }
            self.movies.append(contentsOf: newMovies)
            totalPages = result.totalPages
            currentPage += 1
        } catch {
            self.error = error as? MovieError ?? .unexpectedError(error: error)
        }
        isLoading = false
        isFetchingNextPage = false
    }
    
    func reset() {
        movies = []
        currentPage = 1
        totalPages = 1
    }
}
