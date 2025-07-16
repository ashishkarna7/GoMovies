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
        VStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
            
            Text(error.errorDescription ?? "")
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    ErrorView(error: .decodingError)
}
