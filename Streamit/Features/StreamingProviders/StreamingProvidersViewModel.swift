//
//  StreamingProvidersViewModel.swift
//  Streamit
//
//  Created by Bálna on 01/02/2025.
//

import Combine
import SwiftUI

final actor StreamingProvidersViewModel: ObservableObject {
    enum Action {
        case viewDidAppear
        case downloadImage(url: URL?)
    }

    @Published
    @MainActor
    private(set) var listItems = [StreamingProviderCell.Data]()

    private let streamingProviderRepository: StreamingProviderRepository
    private var cancellables = Set<AnyCancellable>()
    
    @MainActor
    private var fetchTask: Task<(), any Error>?
    @MainActor
    private var imageDownloadTask: Task<(), any Error>?
    @MainActor
    private var subscriptionTask: Task<(), any Error>?

    init(streamingProviderRepository: StreamingProviderRepository) {
        self.streamingProviderRepository = streamingProviderRepository
    }
    
    deinit {
        fetchTask?.cancel()
        fetchTask = nil
        imageDownloadTask?.cancel()
        imageDownloadTask = nil
        subscriptionTask?.cancel()
        subscriptionTask = nil
    }

    @MainActor
    func handle(action: Action) {
        switch action {
        case .viewDidAppear:
            fetchTask = Task {
                _ = try await streamingProviderRepository.watchProviders()
            }
        case .downloadImage(url: let url):
            imageDownloadTask =  Task {
                guard let imageData = try await streamingProviderRepository.downloadImage(from: url),
                      let uiImage = UIImage(data: imageData) else { return }

                if let index = listItems.firstIndex(where: { $0.url == url }) {
                    listItems[index].image = Image(uiImage: uiImage)
                }
            }
        }
    }
    
    @MainActor
    func observe() {
        subscriptionTask = Task {
            for await providers in await streamingProviderRepository.providerCache {
                listItems = providers.map { (provider: WatchProvider) in
                    StreamingProviderCell.Data(name: provider.name, url: provider.logoURL)
                }
            }
        }
    }
}
