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
    private var configurationManager: ConfigurationManager
    private var imageService: ImageService

    var body: some Scene {
        WindowGroup {
            RootView(
                configurationManager: configurationManager,
                streamingProviderRepository: StreamingProviderRepository(
                    apiClient: apiClient,
                    watchProviderDataSource: WatchProviderDataSource(apiClient: apiClient, configurationManager: configurationManager)
                ),
                imageService: imageService
            )
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
            configurationManager = ConfigurationManager(apiClient: apiClient)
            imageService = ImageService(apiClient: apiClient)
        } catch {
            logger.critical("APIClient could not created!")
            fatalError("Critical error happened: \(error)")
        }
    }
}
