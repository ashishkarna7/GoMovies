//
//  MovieClient.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation
import SwiftUI

actor MovieClient {
    static let shared = MovieClient()
    private let imageCache: NSCache<NSString, CacheEntryObject> = NSCache()
    private let downloader: any HttpDataDownloader
    private let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwN2VhYzc0YjhkNWJjYTFjMTg3MWYzZGZlZjZjNWE2NiIsIm5iZiI6MTc1MjQyNDkyNC4xOTM5OTk4LCJzdWIiOiI2ODczZTFkY2FhOGJjMjAwNDFiYTM5NjciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.AetAhpH9-RMPVqEnMyiDhUrkJzMEyX2dUOMTqo-qgps"
//    private let apiKey = ""
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let userDefaults = UserDefaults.standard
    
    private let keyLastUsedQuery = "key_last_search_query"
    
    private func loadLastSearchKey() -> String {
        userDefaults.value(forKey: keyLastUsedQuery) as? String ?? ""
    }
    
    private func saveSearchKey(query: String) {
        userDefaults.set(query, forKey: keyLastUsedQuery)
        userDefaults.synchronize()
    }
    
    init(downloader: any HttpDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    func searchMovie(query: String, page: Int) async throws -> MovieSearchResult {
        var tempQuery = query
        if query.isEmpty {
            tempQuery = loadLastSearchKey()
        }
        let urlRequest = buildUrl(path: "search/movie",
                                 queryItems: [.init(name: "query", value: tempQuery),
                                              .init(name: "include_adult", value: "false"),
                                              .init(name: "language", value: "en-US"),
                                              .init(name: "page", value: "\(page)")])
        
        guard let urlRequest, let _ = urlRequest.url else {
            throw MovieError.invalidRequest
        }
        
        let data = try await downloader.httpData(from: urlRequest)
        
        do {
            let movieSearchResult = try decoder.decode(MovieSearchResult.self, from: data)
            saveSearchKey(query: tempQuery)
            return movieSearchResult
        } catch {
            throw MovieError.decodingError
        }
    }
    
    func movie(id: Int) async throws -> MovieDetail {
        let urlRequest = buildUrl(path: "movie/\(id)", queryItems: [])
        guard let urlRequest, let _ = urlRequest.url else {
            throw MovieError.invalidRequest
        }
        let data = try await downloader.httpData(from: urlRequest)
        do {
            let movie = try decoder.decode(MovieDetail.self, from: data)
            return movie
        } catch {
            throw MovieError.decodingError
        }
    }
    
    func image(from url: URL) async throws -> UIImage {
        if let cached = imageCache[url] {
            switch cached {
            case .inProgress(let task):
                return try await task.value
            case .ready(let uIImage):
                return uIImage
            }
        }
        
        let task = Task<UIImage, Error> {
            let data = try await downloader.httpData(from: URLRequest(url: url))
            guard let image = UIImage(data: data) else {
                throw MovieError.decodingError
            }
            return image
        }
        
        imageCache[url] = .inProgress(task)
        
        do {
            let image = try await task.value
            imageCache[url] = .ready(image)
            return image
        } catch {
            imageCache[url] = nil
            throw error
        }
    }
    
    private func buildUrl(path: String, queryItems: [URLQueryItem]) -> URLRequest? {
        var urlComponent = URLComponents(url: baseURL.appending(path: path), resolvingAgainstBaseURL: false)
        urlComponent?.queryItems = queryItems
        guard let url = urlComponent?.url else { return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
