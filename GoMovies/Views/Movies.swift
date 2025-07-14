//
//  Movies.swift
//  GoMovies
//
//  Created by Ashish Karna on 13/07/2025.
//

import SwiftUI

struct Movies: View {
    @Environment(MovieProvider.self) var provider
    
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
         await provider.searchMovie(query: "a")
    }
}

#Preview {
    Movies()
}
