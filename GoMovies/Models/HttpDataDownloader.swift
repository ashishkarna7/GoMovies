//
//  HttpDataDownloader.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation

let validStatus = 200...299

protocol HttpDataDownloader: Sendable {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HttpDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwN2VhYzc0YjhkNWJjYTFjMTg3MWYzZGZlZjZjNWE2NiIsIm5iZiI6MTc1MjQyNDkyNC4xOTM5OTk4LCJzdWIiOiI2ODczZTFkY2FhOGJjMjAwNDFiYTM5NjciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.AetAhpH9-RMPVqEnMyiDhUrkJzMEyX2dUOMTqo-qgps",
                            forHTTPHeaderField: "Authorization")
        guard let (data, response) = try await self.data(for: urlRequest, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw MovieError.networkError
        }
        return data
    }
}
