//
//  StreamitApp.swift
//  Streamit
//
//  Created by Bálna on 2024. 04. 09..
//

import OSLog
import SwiftUI

@main
struct StreamitApp: App {
    private var logger: Logger
    private var apiClient: ApiClientInterface

    var body: some Scene {
        WindowGroup {
            StreamingProvidersView(
                viewModel: StreamingProvidersViewModel(
                    apiClient: apiClient,
                    imageConfiguration: Configuration.shared.imageConfiguration))
        }
    }

    init() {
        do {
            logger = Logger(subsystem: "com.balintlakatos.TMDB", category: "main")

            let env = EnvironmentProvider.environment
            switch env {
            case .mock: apiClient = MockApiClient()
            default: apiClient = try ApiClient()
            }

            loadConfigurations()
        } catch {
            logger.critical("APIClient could not created!")
            fatalError("Critical error happened!")
        }
    }

    private func loadConfigurations() {
        Task {
            Configuration.shared.countries = try await apiClient.countries()
            Configuration.shared.imageConfiguration = try await apiClient.imageConfiguration()
        }
    }
}
