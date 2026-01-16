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
    private let configurationManager: ConfigurationManager
    
    private var providerCacheSubject: AsyncStream<[WatchProvider]>.Continuation?
    private let imageCacheSubject = CurrentValueSubject<[URL: Data], Never>([:])
    
    var providerCache: AsyncStream<[WatchProvider]> {
        AsyncStream { continuation in
            self.providerCacheSubject = continuation
        }
    }
    var imageCache: AnyPublisher<[URL: Data], Never> {
        imageCacheSubject.eraseToAnyPublisher()
    }
    
    init(apiClient: ApiClientInterface, configurationManager: ConfigurationManager) {
        self.apiClient = apiClient
        self.configurationManager = configurationManager
    }

    func watchProviders() async throws -> [WatchProvider] {
        let providers = try await apiClient.watchProviders()
        let baseURL = await configurationManager.configuration?.imageConfiguration.secureBaseURL

        let watchProviders = providers.map { (provider: WatchProvider) in
            var provider = provider
            if let logoPath = provider.logoPath,
               let baseURL = baseURL {
                provider.logoURL = baseURL.appending(path: "w154").appending(path: logoPath.path())
            }
            return provider
        }
        
        providerCacheSubject?.yield(watchProviders)
        return watchProviders
    }
    
    func downloadImage(from url: URL?) async throws -> Data? {
        guard let url else { return nil}
        var currentValue = imageCacheSubject.value
        
        // return cached `Data`
        if let imageData = currentValue[url] { return imageData }
        
        // download if needed
        let imageData = try await apiClient.downloadImageData(url: url)
        currentValue[url] = imageData
        imageCacheSubject.send(currentValue)
        
        return imageData
    }
}
