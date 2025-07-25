//
//  SwiftUIView.swift
//  GoMovies
//
//  Created by Ashish Karna on 19/07/2025.
//

import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    @State private var phase: AsyncImagePhase
    let url: URL?
    private let content: (AsyncImagePhase) -> Content
    private let client: MovieClient
    
    init(url: URL?, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content, client: MovieClient = .shared ) {
        self.url = url
        self.content = content
        self._phase = State(wrappedValue: .empty)
        self.client = client
    }
    
    var body: some View {
       content(phase)
            .task(id: url, load)
    }
    
    @Sendable
    private func load() async {
        guard let url = url else {
            phase = .empty
            return
        }
        
        do {
            let uiImage = try await client.image(from: url)
            let image = Image(uiImage: uiImage)
            phase = .success(image)
        } catch {
            phase = .failure(error)
        }
    }
}

