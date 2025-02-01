//
//  StreamingProvidersViewModel.swift
//  Streamit
//
//  Created by Bálna on 01/02/2025.
//

import Combine

@MainActor
final class StreamingProvidersViewModel: ObservableObject {
    enum Action {
        case viewDidAppear
    }

    @Published
    private(set) var providers = [WatchProvider]()

    private let apiClient: ApiClientInterface

    init(apiClient: ApiClientInterface) {
        self.apiClient = apiClient
    }

    func handle(action: Action) {
        switch action {
        case .viewDidAppear:
            Task {
                providers = try await apiClient.watchProviders()
            }
        }
    }
}
