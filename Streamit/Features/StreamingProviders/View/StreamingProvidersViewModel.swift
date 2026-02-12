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
    
    enum State {
        case initial
        case loading
        case loaded([StreamingProviderCell.Data])
        case failed
    }

    @Published
    private(set) var listItems = [StreamingProviderCell.Data]()
    @Published
    private(set) var state = State.initial

    private let streamingProviderRepository: StreamingProviderRepository
    private var cancellables = Set<AnyCancellable>()
    
    private var fetchTask: Task<(), any Error>?

    init(streamingProviderRepository: StreamingProviderRepository) {
        self.streamingProviderRepository = streamingProviderRepository
    }
    
    deinit {
        fetchTask?.cancel()
        fetchTask = nil
    }

    func handle(action: Action) {
        switch action {
        case .viewDidAppear:
            handleStateUpdate(newState: .loading)
        }
    }
}

private extension StreamingProvidersViewModel {
    func handleStateUpdate(newState: State) {
        switch (state, newState) {
        case (.initial, .loading):
            state = .loading
            fetchTask = Task {
                do {
                    let providers = try await streamingProviderRepository.watchProviders()
                    let data = providers.map { (provider: WatchProvider) in
                        StreamingProviderCell.Data(name: provider.name, url: provider.logoURL)
                    }
                    state = .loaded(data)
                } catch {
                    state = .failed
                }
            }
        default: break
        }
    }
}
