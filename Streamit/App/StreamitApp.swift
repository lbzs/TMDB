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
            RootView(
                configuration: ConfigurationManager(apiClient: apiClient),
                apiClient: apiClient
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
        } catch {
            logger.critical("APIClient could not created!")
            fatalError("Critical error happened: \(error)")
        }
    }
}
