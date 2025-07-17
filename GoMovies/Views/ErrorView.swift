//
//  ErrorView.swift
//  GoMovies
//
//  Created by Ashish Karna on 16/07/2025.
//

import SwiftUI

struct ErrorView: View {
    var error: MovieError
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
            Text(error.errorDescription ?? "")
        }
        .font(.callout)
        .foregroundStyle(.white)
        .padding()
        .background(.red.opacity(0.9), in: Capsule())
        .padding(.bottom)
    }
}

#Preview {
    ErrorView(error: .decodingError)
}
