//
//  ApiClient.swift
//  ApiClient
//
//  Created by Bálna on 09/04/2024.
//

import TMDb

public protocol ApiClientInterface {
    func popularMovies() async throws -> [Movie]
}

public struct ApiClient: ApiClientInterface {
    private let client: TMDbClient
    
    public init() throws {
        client = TMDbClient(apiKey: "")
    }
    
    public func popularMovies() async throws -> [Movie] {
        try await client
            .movies
            .popular(page: 1, country: nil, language: nil)
            .results
            .map { .init(apimodel: $0)}
    }
}

public struct MockApiClient: ApiClientInterface {
    public init() {}
    public func popularMovies() async throws -> [Movie] {
        try await Task.sleep(nanoseconds: 100)
        return [Movie(id: 1, title: "Alien", originalTitle: "Alien", originalLanguage: "en", overview: "overview")]
    }
}
