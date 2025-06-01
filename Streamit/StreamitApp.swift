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
                    configuration: Configuration.shared))
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
            fatalError("Critical error happened: \(error)")
        }
    }

    private func loadConfigurations() {
        Task {
            do {
                let countries = try await apiClient.countries()
                await Configuration.shared.update(countries: countries)
                let imageConfiguration = try await apiClient.imageConfiguration()
                await Configuration.shared.update(imageConfiguration: imageConfiguration)
            } catch {
                logger.critical("Critical error happened while downloading the configuratino: \(error)")
                fatalError("Error happened: \(error)")
            }
        }
    }
}
