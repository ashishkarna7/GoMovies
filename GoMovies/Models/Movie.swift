//
//  Movie.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import Foundation

struct MovieSearchResult: Decodable {
    let results: [Movie]
    let totalPages: Int
}

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let releaseDate: String?
    private let posterPath: String?
    let overview: String?

    var posterURL: URL? {
        guard let posterPath else { return nil }
        let url = URL(string: AppConstant.imageBaseURL + "w200" + posterPath)
        return url
    }
    
    var posterDetailURL: URL? {
        guard let posterPath else { return nil }
        let url = URL(string: AppConstant.imageBaseURL + "w500" + posterPath)
        return url
    }
}

extension Movie {
    static let example = Movie(id: 1,
                                  title: "Interstellar",
                                  releaseDate: "2014-11-05",
                                  posterPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
                                  overview: "Story of time relativity")
}

//{
//    "page": 1,
//    "results": [
//        {
//            "adult": false,
//            "backdrop_path": "/51zEsrnLuMnTYjvM0xI2cmk2rxh.jpg",
//            "genre_ids": [
//                18,
//                10402
//            ],
//            "id": 461191,
//            "original_language": "en",
//            "original_title": "A",
//            "overview": "A young alcoholic ambient musician locks himself in his apartment on a dangerous seven day bender as he attempts to finish his upcoming album.",
//            "popularity": 1.0626,
//            "poster_path": "/4uOKZzRB615cIxcVi31pcsdFtSS.jpg",
//            "release_date": "2017-09-13",
//            "title": "A",
//            "video": false,
//            "vote_average": 6.18,
//            "vote_count": 203
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [],
//            "id": 1286889,
//            "original_language": "en",
//            "original_title": "A",
//            "overview": "In a close-knit community, imagine a teenager’s struggle with asexuality, where faith clashes with personal discovery.",
//            "popularity": 0.5791,
//            "poster_path": "/lv9a4uVBysAVqfKSZRYIdco2liL.jpg",
//            "release_date": "2024-05-15",
//            "title": "A",
//            "video": false,
//            "vote_average": 5.918,
//            "vote_count": 55
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/opNdWurarqYxrzqpVRPyZrbWb3K.jpg",
//            "genre_ids": [
//                27,
//                53,
//                9648
//            ],
//            "id": 1029880,
//            "original_language": "da",
//            "original_title": "Nattevagten - Dæmoner går i arv",
//            "overview": "Martin's daughter, Emma, takes up a night watch job to find out what happened to her parents almost thirty years ago. A meeting with Wörmer in his cell pulls the serial killer out of his coma and sets in motion a chain of fateful events.",
//            "popularity": 4.3808,
//            "poster_path": "/7Bj9qbmTiBdOmVlHeQqoEjsDxul.jpg",
//            "release_date": "2023-12-14",
//            "title": "Nightwatch: Demons Are Forever",
//            "video": false,
//            "vote_average": 6.253,
//            "vote_count": 73
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/qtSY2SAL5QApuCUD0sXqyzgHYnl.jpg",
//            "genre_ids": [
//                28,
//                35,
//                80,
//                9648
//            ],
//            "id": 1374534,
//            "original_language": "nl",
//            "original_title": "Bad Boa's",
//            "overview": "When an overeager community officer and a reckless ex-detective are forced to team up, plenty of chaos ensues on the streets of Rotterdam.",
//            "popularity": 425.9085,
//            "poster_path": "/7bcndiaTgu1Kj5a6qyCmsWYdtI.jpg",
//            "release_date": "2025-07-10",
//            "title": "Almost Cops",
//            "video": false,
//            "vote_average": 5.093,
//            "vote_count": 27
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/c3rwwFFVbkyEI6wPtpPd9lvovPW.jpg",
//            "genre_ids": [
//                28,
//                36
//            ],
//            "id": 1311550,
//            "original_language": "en",
//            "original_title": "House of Ga'a",
//            "overview": "At the height of the Oyo Empire, the ferocious Bashorun Ga'a became more powerful than the kings he enthroned, only to be undone by his own blood.",
//            "popularity": 5.016,
//            "poster_path": "/6yK9hmS641NMwRkR1wWAALWI34t.jpg",
//            "release_date": "2024-07-26",
//            "title": "House of Ga'a",
//            "video": false,
//            "vote_average": 5.5,
//            "vote_count": 117
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/fzhvjT11iGiTTralGks7EVJwVb6.jpg",
//            "genre_ids": [
//                99,
//                18
//            ],
//            "id": 1427792,
//            "original_language": "es",
//            "original_title": "A.",
//            "overview": "Having lost her memory, A. could barely recall glimpses of her childhood in Argentina. After her death, her son visits the empty house for the last time. A sensory journey through a house without objects but filled with memory.",
//            "popularity": 0.1219,
//            "poster_path": "/r0Hqb2529mtXQZWpIjCAHGzD8cp.jpg",
//            "release_date": "2025-02-26",
//            "title": "A.",
//            "video": false,
//            "vote_average": 6.75,
//            "vote_count": 6
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [],
//            "id": 317735,
//            "original_language": "it",
//            "original_title": "A",
//            "overview": "Experimental short by Anna Lajolo and Guido Lombardi.",
//            "popularity": 0.1862,
//            "poster_path": "/mFAdbTVkhvYzgQ7tULBzy3LbHlh.jpg",
//            "release_date": "1969-06-12",
//            "title": "A",
//            "video": false,
//            "vote_average": 5.741,
//            "vote_count": 27
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/pAJX9KA8fL0ktVVVKNI5GyVfcWZ.jpg",
//            "genre_ids": [
//                16,
//                12,
//                14,
//                10751
//            ],
//            "id": 1355755,
//            "original_language": "en",
//            "original_title": "An Almost Christmas Story",
//            "overview": "A young owl meets a lost little girl in New York City. Together, they try to get home for Christmas.",
//            "popularity": 4.1208,
//            "poster_path": "/mQC3nIJ9DQ74t9vFzUjqP8eohgX.jpg",
//            "release_date": "2024-10-14",
//            "title": "An Almost Christmas Story",
//            "video": false,
//            "vote_average": 7.2,
//            "vote_count": 69
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [
//                27,
//                18,
//                9648,
//                53
//            ],
//            "id": 333465,
//            "original_language": "el",
//            "original_title": "A",
//            "overview": "A woman is forced to sit under a hanged rotting corpse in the middle of a burnt forest, until the authorities decide that she has been punished enough.",
//            "popularity": 0.3733,
//            "poster_path": "/cE84z1uZgNhvGsVDjSsZHK3b5sY.jpg",
//            "release_date": "2015-01-25",
//            "title": "Alpha",
//            "video": false,
//            "vote_average": 5.5,
//            "vote_count": 16
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [],
//            "id": 1341416,
//            "original_language": "en",
//            "original_title": "A",
//            "overview": "",
//            "popularity": 0.1647,
//            "poster_path": "/qxFO4Zuu7008k2vOeSgt36zNJlh.jpg",
//            "release_date": "",
//            "title": "A",
//            "video": false,
//            "vote_average": 0.0,
//            "vote_count": 0
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/tVtjUhgXO9tFjgLvGV0L4WF4I5d.jpg",
//            "genre_ids": [
//                16
//            ],
//            "id": 277218,
//            "original_language": "en",
//            "original_title": "A",
//            "overview": "A writer is persecuted by an enormous and abusive letter 'A'.",
//            "popularity": 0.0656,
//            "poster_path": "/hfniiftuGyPDlZyM2RxjoVGioel.jpg",
//            "release_date": "1965-01-02",
//            "title": "A",
//            "video": false,
//            "vote_average": 6.314,
//            "vote_count": 35
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [],
//            "id": 846232,
//            "original_language": "tl",
//            "original_title": "A",
//            "overview": "Ken spends his days getting ready for his new lead role and getting into the skin of his new character: A, a troubled young man who tries to commit suicide after getting rejected by the man he loves. But Ken has another fight to deal with and while his family and friends are supportive, his hope to win this battle is slowly dying. Will fiction bleed into real life?",
//            "popularity": 0.117,
//            "poster_path": "/1ePNhELD8o9r8ZyANFb0qkLJmEj.jpg",
//            "release_date": "2019-08-26",
//            "title": "A",
//            "video": false,
//            "vote_average": 6.528,
//            "vote_count": 18
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [],
//            "id": 933844,
//            "original_language": "en",
//            "original_title": "A",
//            "overview": "Made in 1986, one of the first videos dealing with AIDS.",
//            "popularity": 0.0322,
//            "poster_path": "/lz7AffadG4eBS70cjEcfIZWGPw7.jpg",
//            "release_date": "1986-01-01",
//            "title": "A",
//            "video": false,
//            "vote_average": 5.269,
//            "vote_count": 13
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/2Hg61bddHFD6d2J4WQtL88GHofz.jpg",
//            "genre_ids": [
//                35,
//                18
//            ],
//            "id": 664188,
//            "original_language": "xx",
//            "original_title": "A",
//            "overview": "A world like ours, limited by language.",
//            "popularity": 0.08,
//            "poster_path": "/q8prmdgecmc1n2YZCu32ybsbiIt.jpg",
//            "release_date": "2017-11-24",
//            "title": "A",
//            "video": false,
//            "vote_average": 5.528,
//            "vote_count": 18
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [
//                99
//            ],
//            "id": 944824,
//            "original_language": "en",
//            "original_title": "A",
//            "overview": "Single-channel video installation commissioned by Public Art Development Trust, London.",
//            "popularity": 0.1813,
//            "poster_path": "/7LhPaLmbRJ8NzovDxCYFD6kss9G.jpg",
//            "release_date": "2002-09-25",
//            "title": "A",
//            "video": false,
//            "vote_average": 6.9,
//            "vote_count": 19
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [],
//            "id": 984953,
//            "original_language": "tl",
//            "original_title": "A",
//            "overview": "Ken spends his days getting ready for his new lead role and getting into the skin of his new character: A, a troubled young man who tries to commit suicide after getting rejected by the man he loves. But Ken has another fight to deal with and while his family and friends are supportive, his hope to win this battle is slowly dying. Will fiction bleed into real life?",
//            "popularity": 0.0883,
//            "poster_path": "/4Zk1JpUCImQFTqstnuhC0vhCH2V.jpg",
//            "release_date": "2019-08-26",
//            "title": "A",
//            "video": false,
//            "vote_average": 6.194,
//            "vote_count": 18
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [],
//            "id": 877294,
//            "original_language": "it",
//            "original_title": "a",
//            "overview": "Photographs by my father Giacomo Mazzola and a video depicting Sironi’s painting Mountains: a gesture of remembrance in three chapters.",
//            "popularity": 0.0596,
//            "poster_path": "/wfAJf5rhxTt0ECHd7GJDAUOCixX.jpg",
//            "release_date": "2019-05-01",
//            "title": "a",
//            "video": false,
//            "vote_average": 6.533,
//            "vote_count": 15
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [
//                18
//            ],
//            "id": 895800,
//            "original_language": "fr",
//            "original_title": "A",
//            "overview": "Some fragments of the story of a young man alone and in search of love. A film adaptation of play \"A\", an unpublished solo by Antoine Pelletier exploring contemporary LGBT2SQ + relationships.",
//            "popularity": 0.0239,
//            "poster_path": "/ybnEmjgFfKcj7VJaXOfS9ui6akz.jpg",
//            "release_date": "2021-07-15",
//            "title": "A",
//            "video": false,
//            "vote_average": 5.2,
//            "vote_count": 15
//        },
//        {
//            "adult": false,
//            "backdrop_path": null,
//            "genre_ids": [],
//            "id": 741876,
//            "original_language": "en",
//            "original_title": "A",
//            "overview": "A is a 1998 Japanese documentary film about the Aum Shinrikyo cult following the arrest of its leaders for instigating the sarin gas attack on the Tokyo subway in 1995. The film focuses on a young spokesman for the cult Hiroshi Araki, a troubled 28-year-old who had severed all family ties and rejected all forms of materialism before joining the sect.  Director Tatsuya Mori was allowed exclusive access to Aum's offices for over a year as news media were continually kept out. However, despite the documentary's unique perspective on Aum's internal workings, it was not financially successful.  Mori released the sequel A2 in 2001, which followed the dissolution of the cult in the absence of their leader, Shoko Asahara.",
//            "popularity": 0.0598,
//            "poster_path": null,
//            "release_date": "",
//            "title": "A",
//            "video": true,
//            "vote_average": 5.885,
//            "vote_count": 13
//        },
//        {
//            "adult": false,
//            "backdrop_path": "/9A0wQG38VdEu3DYh8HzXKXKhA6g.jpg",
//            "genre_ids": [
//                12,
//                35,
//                10751
//            ],
//            "id": 1287536,
//            "original_language": "en",
//            "original_title": "Dora and the Search for Sol Dorado",
//            "overview": "Dora, Diego, and their new friends trek through the perilous dangers of the Amazonian jungle in search of the ancient and powerful treasure of Sol Dorado to keep it out of enemy hands.",
//            "popularity": 225.5711,
//            "poster_path": "/r3d6u2n7iPoWNsSWwlJJWrDblOH.jpg",
//            "release_date": "2025-07-02",
//            "title": "Dora and the Search for Sol Dorado",
//            "video": false,
//            "vote_average": 7.17,
//            "vote_count": 44
//        }
//    ],
//    "total_pages": 500,
//    "total_results": 10000
//}
