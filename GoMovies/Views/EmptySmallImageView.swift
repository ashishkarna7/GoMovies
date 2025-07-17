//
//  EmptySmallImageView.swift
//  GoMovies
//
//  Created by Ashish Karna on 17/07/2025.
//

import SwiftUI

struct EmptySmallImageView: View {
    var body: some View {
        Rectangle()
            .fill(.gray.opacity(0.3))
            .frame(width: 60, height: 90)
            .cornerRadius(6)
            .overlay {
                Image(systemName: "photo.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    EmptySmallImageView()
}
