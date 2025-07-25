//
//  FavoritesViewModel.swift
//  GoMovies
//
//  Created by Ashish Karna on 19/07/2025.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    var movies: [Movie]
    
    init(movies: [Movie] = []) {
        self.movies = movies
    }
}
