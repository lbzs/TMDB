//
//  ApiClient.swift
//  ApiClient
//
//  Created by Bálna on 09/04/2024.
//

import Foundation
import TMDb

public protocol ApiClientInterface {
    func popularMovies() async throws -> [MovieListItem]
    func movieDetails(movieId: Int) async throws -> Movie
    func watchProviders() async throws -> [WatchProvider]
    func countries() async throws -> [Country]
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
    
    public func watchProviders() async throws -> [WatchProvider] {
        try await client
            .watchProviders
            .movieWatchProviders(filter: nil, language: nil)
            .map { .init(id: $0.id, name: $0.name, logoPath: $0.logoPath) }
    }
    
    public func countries() async throws -> [Country] {
        try await client
            .configurations
            .countries()
            .map { .init(id: $0.id, countryCode: $0.countryCode, name: $0.name, englishName: $0.englishName) }
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
    public func watchProviders() async throws -> [WatchProvider] {
        try await Task.sleep(nanoseconds: 100)
        return [WatchProvider(id: 1, name: "Netflix", logoPath: URL(string: "/t2yyOv40HZeVlLjYsCsPHnWLk4W.jpg")!)]
    }
    public func countries() async throws -> [Country] {
        try await Task.sleep(nanoseconds: 100)
        return [Country(id: "1", countryCode: "1", name: "USA", englishName: "USA")]
    }
}
