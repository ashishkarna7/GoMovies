//
//  TestDownloader.swift
//  GoMovies
//
//  Created by Ashish Karna on 15/07/2025.
//

import Foundation

final class TestDownloader: HttpDataDownloader {
    func httpData(from: URLRequest) async throws -> Data {
        try await Task.sleep(for: .milliseconds(.random(in: 100...500)))
        return testSearchData
    }
}

final class DetailTestDownloader: HttpDataDownloader {
    func httpData(from: URLRequest) async throws -> Data {
        try await Task.sleep(for: .milliseconds(.random(in: 100...500)))
        return testMovieObjectData
    }
}
