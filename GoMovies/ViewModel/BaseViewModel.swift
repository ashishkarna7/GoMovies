//
//  BaseViewModel.swift
//  GoMovies
//
//  Created by Ashish Karna on 19/07/2025.
//

import Foundation

@Observable
class BaseViewModel {
    
    var isLoading = false
    
    var error: MovieError?
    
    let client: MovieClient
    
    init(client: MovieClient = .shared) {
        self.client = client
    }
}
