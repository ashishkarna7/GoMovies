//
//  Movie.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation
import SwiftData

struct MovieSearchResult: Decodable {
    let results: [MovieDTO]
    let totalPages: Int
}

struct MovieDTO: Identifiable, Decodable {
    let id: Int
    let title: String
    let releaseDate: String?
    let posterPath: String?
    
    func toMovie() -> Movie {
        let movie = Movie(movieId: id,
                          title: title,
                          releaseDate: releaseDate,
                          posterPath: posterPath)
        return movie
    }
}

@Model
class Movie {
    var movieId: Int
    var title: String
    var releaseDate: String?
    var posterUrl: URL?
    var posterPath: String?
    
    init(movieId: Int, title: String, releaseDate: String? = nil, posterPath: String? = nil) {
        self.movieId = movieId
        self.title = title
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        
        var posterUrl: URL? = nil
        if let posterPath = self.posterPath {
            posterUrl = URL(string: AppConstant.imageBaseURL + "w200" + posterPath)
        }
        self.posterUrl = posterUrl
    }
    
    func toMovieDetail() -> MovieDetail {
        var detail = MovieDetail(id: movieId,
                                 title: title,
                                 overview: "",
                                 posterPath: posterPath,
                                 backdropPath: nil,
                                 releaseDate: releaseDate,
                                 voteAverage: nil,
                                 runTime: nil,
                                 genre: nil,
                                 tagline: nil,
                                 homePage: nil)
        detail.smallPosterUrl = posterUrl
        return detail
    }
}
