//
//  MovieClient.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation

actor MovieClient {
    
    private let movieCache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    private let downloader: any HttpDataDownloader
    private let baseURL = URL(string: "https://api.themoviedb.org/3/")!
//    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwN2VhYzc0YjhkNWJjYTFjMTg3MWYzZGZlZjZjNWE2NiIsIm5iZiI6MTc1MjQyNDkyNC4xOTM5OTk4LCJzdWIiOiI2ODczZTFkY2FhOGJjMjAwNDFiYTM5NjciLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.AetAhpH9-RMPVqEnMyiDhUrkJzMEyX2dUOMTqo-qgps"
    private let apiKey = ""
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(downloader: any HttpDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    func searchMovie(query: String, page: Int) async throws -> MovieSearchResult {
        let url = buildUrl(path: "search/movie",
                                 queryItems: [.init(name: "query", value: query),
                                              .init(name: "include_adult", value: "false"),
                                              .init(name: "language", value: "en-US"),
                                              .init(name: "page", value: "\(page)")])
        
        guard let url else {
            throw MovieError.invalidRequest
        }
        
        let data = try await downloader.httpData(from: getUrlRequest(from: url))
        
        do {
            let movieSearchResult = try decoder.decode(MovieSearchResult.self, from: data)
            return movieSearchResult
        } catch {
            throw MovieError.decodingError
        }
    }
    
    func movie(id: Int) async throws -> Movie {
        let url = baseURL.appending(path: "movie/\(id)")
        
        if let cached = movieCache[url] {
            switch cached {
            case .ready(let movie):
                return movie
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        let task = Task<Movie, Error> {
            let data = try await downloader.httpData(from: getUrlRequest(from: url))
            do {
                let movie = try decoder.decode(Movie.self, from: data)
                movieCache[url] = .ready(movie)
                return movie
            } catch {
                throw MovieError.decodingError
            }
        }
        
        movieCache[url] = .inProgress(task)

        return try await task.value
    }
    
    private func buildUrl(path: String, queryItems: [URLQueryItem]) -> URL? {
        var urlComponent = URLComponents(url: baseURL.appending(path: path), resolvingAgainstBaseURL: false)
        urlComponent?.queryItems = queryItems
       return urlComponent?.url
    }
    
    private func getUrlRequest(from url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
