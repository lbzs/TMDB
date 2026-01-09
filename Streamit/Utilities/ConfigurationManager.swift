//
//  ConfigurationManager.swift
//  Streamit
//
//  Created by Bálna on 2025. 12. 12..
//

import Foundation

@MainActor
final class ConfigurationManager: ObservableObject {
    enum ConfigurationState {
        case initial
        case loading
        case loaded
        case failed
    }

    @Published private(set) var state: ConfigurationState = .initial
    private(set) var configuration: Configuration?
    private let apiClient: ApiClientInterface

    init(apiClient: ApiClientInterface) {
        self.apiClient = apiClient
    }

    func loadConfiguration() async {
        state = .loading

        async let countries = apiClient.countries()
        async let imageConfiguration = apiClient.imageConfiguration()

        do {
            configuration = Configuration(
                countries: try await countries,
                imageConfiguration: try await imageConfiguration
            )
            state = .loaded
        } catch {
            state = .failed
        }
    }
}
