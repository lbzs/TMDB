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
    private(set) var providerLogos = [Int: Image]()
    private let defaultLogo = Image(systemName: "photo")

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
                providers = try await apiClient.watchProviders()
                try await withThrowingTaskGroup(of: (Int, Data?).self) { group in
                    let baseURL = imageConfiguration.secureBaseURL
                    for provider in providers {
                        group.addTask { [apiClient] in
                            guard let url = baseURL?.appending(path: "w45").appending(path: provider.logoPath.path()) else {
                                return (provider.id, nil)
                            }
                            return try await (provider.id, apiClient.downloadImageData(url: url))
                        }
                    }

                    for try await logo in group {
                        if let image = logo.1,
                           let uiImage = UIImage(data: image) {
                            providerLogos[logo.0] = Image(uiImage: uiImage)
                        }
                    }
                }
            }
        }
    }

    func logo(for id: WatchProvider.ID) -> Image {
        providerLogos[id] ?? defaultLogo
    }
}
