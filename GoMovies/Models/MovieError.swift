//
//  MovieError.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation

enum MovieError: Error {
    case invalidRequest
    case networkError(statusCode: Int? = nil)
    case decodingError
    case unexpectedError(error: Error)
}

extension MovieError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return NSLocalizedString("Invalid request. Please check your input", comment: "")
        case .decodingError:
            return NSLocalizedString("Failed to decode movie data. Please try again later", comment: "")
        case .networkError(let statusCode):
            if let statusCode {
                return NSLocalizedString("Network error occured. Status code: \(statusCode)", comment: "")
            } else {
                return NSLocalizedString("Error fetching movie data over the network", comment: "")
            }
        case .unexpectedError(let error):
            return NSLocalizedString("Recieved unexpected error: \(error.localizedDescription)", comment: "")
        }
    }
}
