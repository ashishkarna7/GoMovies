//
//  MovieDetail.swift
//  GoMovies
//
//  Created by Ashish Karna on 18/07/2025.
//

import Foundation

struct MovieDetail: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let runTime: Int?
    let genre: [Genre]?
    let tagline: String?
    let homePage: String?
    
    var smallPosterUrl: URL? = nil
    
    
    var posterDetailURL: URL? {
        guard let posterPath else { return nil }
        let url = URL(string: AppConstant.imageBaseURL + "w500" + posterPath)
        return url
    }
    
    func toMovie() -> Movie {
        let movie = Movie(movieId: id, title: title, releaseDate: releaseDate, posterPath: posterPath)
        return movie
    }
}

struct Genre: Identifiable, Decodable {
    let id: Int
    let name: String
}
