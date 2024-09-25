//
//  ApiClient.swift
//  ApiClient
//
//  Created by Bálna on 09/04/2024.
//

import Foundation
import OpenAPIURLSession

public protocol ApiClientInterface {
    func popularMovies() async throws -> [Movie]
}

public struct ApiClient: ApiClientInterface {
    private let client: Client
    private let movieMapper = MovieApiToDomainMapper()
    
    public init() throws {
        client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
    }
    
    public func popularMovies() async throws -> [Movie] {
        let response = try await client.movie_hyphen_popular_hyphen_list(.init())
        switch response {
        case let .ok(pagedResult):
            switch pagedResult.body {
            case let .json(jsonPayload):
                guard let apiModels = jsonPayload.results else { return [] }
                return movieMapper.map(from: apiModels)
            }
        case .undocumented(statusCode: let statusCode, _):
            throw NSError(domain: "", code: statusCode)
        }
    }
}

public struct MockApiClient: ApiClientInterface {
    public init() {}
    public func popularMovies() async throws -> [Movie] {
        try await Task.sleep(nanoseconds: 100)
        return [Movie(id: 1, originalTitle: "Alien", overview: "Alien overview", popularity: 9.2, title: "Alien")]
    }
}
