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

    private let streaminProviderRepository: StreamingProviderRepository

    init(streaminProviderRepository: StreamingProviderRepository) {
        self.streaminProviderRepository = streaminProviderRepository
    }

    func handle(action: Action) {
        switch action {
        case .viewDidAppear:
            Task {
                providers = try await streaminProviderRepository.watchProviders()
            }
        }
    }
}
