//
//  FavoriteButton.swift
//  GoMovies
//
//  Created by Ashish Karna on 17/07/2025.
//

import SwiftUI

struct FavoriteButton: View {
    let isFavorite: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .font(.title2)
                .foregroundStyle(isFavorite ? .yellow : .gray)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    var isFavorited = false
    FavoriteButton(isFavorite: isFavorited, action: {
        isFavorited.toggle()
    })
}
