//
//  PreviewModifier.swift
//  GoMovies
//
//  Created by Ashish Karna on 25/07/2025.
//

import SwiftData
import SwiftUI

struct MovieSampleData: PreviewModifier {
    
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: Movie.self, configurations: .init(isStoredInMemoryOnly: true))
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let searchResult = try decoder.decode(MovieSearchResult.self, from: testSearchData)
        let movies = searchResult.results.map { $0.toMovie() }
        
        movies.forEach({ container.mainContext.insert($0)})
        
        return container
        
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var movieSampleData: Self = .modifier(MovieSampleData())
}
