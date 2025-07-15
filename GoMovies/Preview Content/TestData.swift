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
                "poster_path": "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"
            },
            {
                "id": 2,
                "title": "Inception",
                "release_date": "2010-07-16",
                "poster_path": "/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
            }
        ],
        "total_pages": 1
    }
"""
    return Data(json.utf8)
}()

