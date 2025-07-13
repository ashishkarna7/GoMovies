//
//  MovieError.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation

enum MovieError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension MovieError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Found and will discard a movie missing title", comment: "")
        case .networkError:
            return NSLocalizedString("Error fetching movie data over the network", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString("Recieved unexpected error: \(error.localizedDescription)", comment: "")
        }
    }
}
