//
//  CacheEntryObject.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation

final class CacheEntryObject {
    
    let entry: CacheEntry
    
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

enum CacheEntry {
    case inProgress(Task<Movie, Error>)
    case ready(Movie)
}
