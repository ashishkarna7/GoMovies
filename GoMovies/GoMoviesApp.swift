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
            
            TabView {
                NavigationStack {
                    SearchMoviesView()
                }.tabItem {
                    Label("Home", systemImage: "house")
                }
                
                NavigationStack {
                    FavoritesView()
                }.tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            }
            .environment(movieProvider)
        }
        
    }
}
