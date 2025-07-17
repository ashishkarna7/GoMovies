//
//  EmptyImageView.swift
//  GoMovies
//
//  Created by Ashish Karna on 17/07/2025.
//

import SwiftUI

struct EmptyImageView: View {
    var body: some View {
        Rectangle()
            .fill(.gray.opacity(0.3))
            .frame(height: 300)
            .overlay {
                Image(systemName: "photo.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    EmptyImageView()
}
