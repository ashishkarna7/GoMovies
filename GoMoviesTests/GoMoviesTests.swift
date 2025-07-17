//
//  GoMoviesTests.swift
//  GoMoviesTests
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation
import Testing
@testable import GoMovies

struct GoMoviesTests {
    
    @Test("Decodes tmdb api response")
    func decodeMovieResultJSON() async throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedValue = try decoder.decode(MovieSearchResult.self, from: testSearchData)
        
        let items = decodedValue.results
        
        #expect(items.count == 2)
    }
    
    @Test("Decodes movie object response")
    func decodeMovieJSON() async throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedValue = try decoder.decode(Movie.self, from: testMovieObjectData)
        
        #expect(decodedValue.id == 1)
    }
    
    @Test("Successfully fetched of movie search")
    func searchMovies() async throws {
        let downloader = TestDownloader()
        let client = MovieClient(downloader: downloader)
        
        let searchData = try await client.searchMovie(query: "i", page: 1)
        let movies = searchData.results
        #expect(movies.count == 2)
    }
    
    @Test("Successfully fetched of movie detail")
    func movieDetail() async throws {
        let downloader = DetailTestDownloader()
        let client = MovieClient(downloader: downloader)
        
        let movie = try await client.movie(id: 1)
        #expect(movie.title == "Interstellar")
    }
    
}
