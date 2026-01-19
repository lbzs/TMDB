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
    private var imageCacheSubject = [URL: Data]()
    
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
    
    func downloadImage(from url: URL?) async throws -> Data? {
        guard let url else { return nil}
        
        // return cached `Data`
        if let imageData = imageCacheSubject[url] { return imageData }
        
        // download if needed
        let imageData = try await apiClient.downloadImageData(url: url)
        imageCacheSubject[url] = imageData
        
        return imageData
    }
}
