//
//  StreamingProviderRepository.swift
//  Streamit
//
//  Created by Bálna on 2026. 01. 09..
//

import Foundation

final actor StreamingProviderRepository {
    private let apiClient: ApiClientInterface
    private let configurationManager: ConfigurationManager
    
    init(apiClient: ApiClientInterface, configurationManager: ConfigurationManager) {
        self.apiClient = apiClient
        self.configurationManager = configurationManager
    }
    
    func watchProviders() async throws -> [WatchProvider] {
        let providers = try await apiClient.watchProviders()
        let baseURL = await configurationManager.configuration?.imageConfiguration.secureBaseURL

        return providers.map { (provider: WatchProvider) in
            var provider = provider
            if let logoPath = provider.logoPath,
               let baseURL = baseURL {
                provider.logoURL = baseURL.appending(path: "w154").appending(path: logoPath.path())
            }
            return provider
        }
    }
}
