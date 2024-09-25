//
//  TMDBApp.swift
//  TMDB
//
//  Created by Bálna on 2024. 04. 09..
//

import ApiClient

import SwiftUI
import OSLog

@main
struct TMDBApp: App {
    private var logger: Logger
    private var apiClient: ApiClientInterface
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: PopularMoviesViewModel(apiClient: apiClient))
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
            fatalError("Critical error happened!")
        }
    }
}
