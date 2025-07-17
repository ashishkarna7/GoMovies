//
//  GoMoviesApp.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import SwiftUI
import SwiftData

@main
struct GoMoviesApp: App {    
    @State var movieProvider = MovieProvider()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SearchMoviesView()
            }
            .environment(movieProvider)
        }
        
    }
}
