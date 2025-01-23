//
//  ApiClient.swift
//  ApiClient
//
//  Created by Bálna on 09/04/2024.
//

import TMDb

public protocol ApiClientInterface {
    func popularMovies() async throws -> [MovieListItem]
    func movieDetails(movieId: Int) async throws -> Movie
}

public struct ApiClient: ApiClientInterface {
    private let client: TMDbClient
    
    public init() throws {
        client = TMDbClient(apiKey: "9fc1cf08926295315028ab42632ba267")
    }
    
    public func popularMovies() async throws -> [MovieListItem] {
        try await client
            .movies
            .popular(page: 1, country: nil, language: nil)
            .results
            .map { .init(apiModel: $0)}
    }
    
    public func movieDetails(movieId: Int) async throws -> Movie {
        let apiModel = try await client
            .movies
            .details(forMovie: movieId, language: nil)
        return Movie(apiModel: apiModel)
    }
}

public struct MockApiClient: ApiClientInterface {
    public init() {}
    public func popularMovies() async throws -> [MovieListItem] {
        try await Task.sleep(nanoseconds: 100)
        return [MovieListItem(id: 1, title: "Alien", originalTitle: "Alien", originalLanguage: "en", overview: "overview")]
    }
    public func movieDetails(movieId: Int) async throws -> Movie {
        try await Task.sleep(nanoseconds: 100)
        return Movie(id: 1, title: "Alien", runtime: 111)
    }
}
