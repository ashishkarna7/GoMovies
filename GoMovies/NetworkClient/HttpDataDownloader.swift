//
//  HttpDataDownloader.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation

let validStatus = 200...299

protocol HttpDataDownloader: Sendable {
    func httpData(from: URLRequest) async throws -> Data
}

extension URLSession: HttpDataDownloader {
    func httpData(from urlRequest: URLRequest) async throws -> Data {
        
        let (data, response) = try await self.data(for: urlRequest, delegate: nil)
        
        guard let httpResponse = response as? HTTPURLResponse,
              validStatus.contains(httpResponse.statusCode) else {
            throw MovieError.networkError(statusCode: (response as? HTTPURLResponse)?.statusCode)
        }
        
        return data
    }
}
