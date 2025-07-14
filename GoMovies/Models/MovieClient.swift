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

    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(downloader: any HttpDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    func searchMovie(query: String, page: Int) async throws -> MovieSearchResult {
        var urlComponent = URLComponents(url: baseURL.appending(path: "search/movie"), resolvingAgainstBaseURL: false)
        
        urlComponent?.queryItems = [.init(name: "query", value: query),
                                    .init(name: "include_adult", value: "false"),
                                    .init(name: "language", value: "en-US"),
                                    .init(name: "page", value: "\(page)")]
        
        guard let url = urlComponent?.url else {
            throw MovieError.invalidRequest
        }
        
        let data = try await downloader.httpData(from: url)
        
        do {
            let movieSearchResult = try decoder.decode(MovieSearchResult.self, from: data)
            return movieSearchResult
        } catch {
            throw MovieError.decodingError
        }
    }
    
    func movie(id: Int) async throws -> Movie {
        
        let urlComponent = URLComponents(url: baseURL.appending(path: "movie/\(id)"), resolvingAgainstBaseURL: false)
        
        guard let url = urlComponent?.url else {
            throw MovieError.invalidRequest
        }
        
        if let cached = movieCache[url] {
            switch cached {
            case .ready(let movie):
                return movie
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        let task = Task<Movie, Error> {
            let data = try await downloader.httpData(from: url)
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
}
