//
//  Movies.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import SwiftUI

struct Movies: View {
    @Environment(MovieProvider.self) var provider
    
    @State private var error: MovieError?
    @State private var hasError = false
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(provider.movies) { movie in
                    NavigationLink(destination: {
                        Text("Item at \(movie.title)")
                    }, label: {
                        Text(movie.title)
                    })
                }
            }
        } detail: {
            Text("This is detail page")
        }
        .task {
            await fetchMovies()
        }
    }
    
    func fetchMovies() async {
        do {
            try await provider.fetchMovies()
        } catch {
            self.error = error as? MovieError ?? .unexpectedError(error: error)
            hasError = true
        }
    }
}

#Preview {
    Movies()
}
