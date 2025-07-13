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
    private let feedURL = URL(string: "https://api.themoviedb.org/3/movie/11")!
    
    var movies: [Movie] {
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let movies = try decoder.decode([Movie].self, from: data)
            return movies
        }
    }
    
    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()
    
    init(downloader: any HttpDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
}
