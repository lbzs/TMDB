//
//  StreamingProvidersViewModel.swift
//  Streamit
//
//  Created by Bálna on 01/02/2025.
//

import Combine
import SwiftUI

@MainActor
final class StreamingProvidersViewModel: ObservableObject {
    enum Action {
        case viewDidAppear
    }

    @Published
    private(set) var providers = [WatchProvider]()

    private let apiClient: ApiClientInterface
    private let configuration: Configuration?

    init(apiClient: ApiClientInterface, configuration: Configuration?) {
        self.apiClient = apiClient
        self.configuration = configuration
    }

    func handle(action: Action) {
        switch action {
        case .viewDidAppear:
            Task {
                let providers = try await apiClient.watchProviders()

                guard let baseURL = configuration?.imageConfiguration.secureBaseURL else {
                    fatalError("baseURL shouln't be nil!")
                }

                self.providers = providers.map { (provider: WatchProvider) in
                    var provider = provider
                    if let logoPath = provider.logoPath {
                        provider.logoURL = baseURL.appending(path: "w154").appending(path: logoPath.path())
                    }
                    return provider
                }
            }
        }
    }
}
