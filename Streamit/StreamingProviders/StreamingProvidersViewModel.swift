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
    @Published
    private(set) var logoURLs = [Int: URL]()

    private let apiClient: ApiClientInterface
    private let imageConfiguration: ImageConfiguration

    init(apiClient: ApiClientInterface, imageConfiguration: ImageConfiguration) {
        self.apiClient = apiClient
        self.imageConfiguration = imageConfiguration
    }

    func handle(action: Action) {
        switch action {
        case .viewDidAppear:
            Task {
                let providers = try await apiClient.watchProviders()

                let baseURL = imageConfiguration.secureBaseURL
                for provider in providers {
                    logoURLs[provider.id] = baseURL?.appending(path: "w154").appending(path: provider.logoPath.path())
                }

                self.providers = providers
            }
        }
    }
}
