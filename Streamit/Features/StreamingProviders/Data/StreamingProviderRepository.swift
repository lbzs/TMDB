//
//  StreamingProviderRepository.swift
//  Streamit
//
//  Created by Bálna on 2026. 01. 09..
//

import Combine
import Foundation

final actor StreamingProviderRepository {
    private let apiClient: ApiClientInterface
    private let watchProviderDataSource: WatchProviderDataSource
    
    private var providerCacheSubject: AsyncStream<[WatchProvider]>.Continuation?
    
    var providerCache: AsyncStream<[WatchProvider]> {
        AsyncStream { continuation in
            self.providerCacheSubject = continuation
        }
    }
    
    init(apiClient: ApiClientInterface, watchProviderDataSource: WatchProviderDataSource) {
        self.apiClient = apiClient
        self.watchProviderDataSource = watchProviderDataSource
    }

    func watchProviders() async throws -> [WatchProvider] {
        let watchProviders = try await watchProviderDataSource.getWatchProviders()
        providerCacheSubject?.yield(watchProviders)
        return watchProviders
    }
}
