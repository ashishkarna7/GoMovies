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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State var movieProvider = MovieProvider()

    var body: some Scene {
        WindowGroup {
            Movies()
                .environment(movieProvider)
        }
        .modelContainer(sharedModelContainer)
        
    }
}
