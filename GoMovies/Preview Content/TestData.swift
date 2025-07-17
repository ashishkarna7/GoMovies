//
//  TestData.swift
//  GoMovies
//
//  Created by Ashish Karna on 15/07/2025.
//

import Foundation

let testSearchData: Data =  {
let json = """
 {
        "results": [
            {
                "id": 1,
                "title": "Interstellar",
                "release_date": "2014-11-05",
                "poster_path": "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
                "overview": "This is the overview text for interstellar"
            },
            {
                "id": 2,
                "title": "Inception",
                "release_date": "2010-07-16",
                "poster_path": "/qJ2tW6WMUDux911r6m7haRef0WH.jpg",
                "overview": "This is the overview text for inception"
            }
        ],
        "total_pages": 1
    }
"""
    return Data(json.utf8)
}()

let testMovieObjectData: Data =  {
    let json = """
             {
                 "id": 1,
                 "title": "Interstellar",
                 "release_date": "2014-11-05",
                 "poster_path": "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
                 "overview": "This is the overview text for interstellar"
             }
"""
    return Data(json.utf8)
}()
