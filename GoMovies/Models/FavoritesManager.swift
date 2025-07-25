//
//  MovieProvider.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation
import Observation

@Observable
class FavoritesManager {
    
    var favoriteMovieIds: Set<Int> {
        didSet {
            saveFavorites()
        }
    }
    
    private let keyFavorite = "key_favorite"

    init() {
        if let data = UserDefaults.standard.data(forKey: keyFavorite) {
            if let ids = try? JSONDecoder().decode(Set<Int>.self, from: data) {
                self.favoriteMovieIds = ids
                return
            }
        }
        favoriteMovieIds = []
    }
    
    func isFavorite(movieId: Int) -> Bool {
        favoriteMovieIds.contains(movieId)
    }
    
    func toggleFavorite(movieId: Int) {
        if isFavorite(movieId: movieId) {
            favoriteMovieIds.remove(movieId)
        } else {
            favoriteMovieIds.insert(movieId)
        }
    }
    
    func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteMovieIds) {
            UserDefaults.standard.set(data, forKey: keyFavorite)
        }
    }
}
