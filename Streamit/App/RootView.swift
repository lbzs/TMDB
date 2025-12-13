//
//  RootView.swift
//  Streamit
//
//  Created by Bálna on 2025. 12. 12..
//

import Foundation
import SwiftUI

struct RootView: View {
    @ObservedObject private var configuration: ConfigurationManager
    private let apiClient: ApiClientInterface

    init(configuration: ConfigurationManager, apiClient: ApiClientInterface) {
        self.configuration = configuration
        self.apiClient = apiClient
    }

    var body: some View {
        switch configuration.state {
        case .initial:
            Color.green
                .task {
                    await configuration.loadConfiguration()
                }
        case .loading:
            ProgressView()
        case .loaded:
            StreamingProvidersView(
                viewModel: StreamingProvidersViewModel(
                    apiClient: apiClient,
                    configuration: configuration.configuration
                ))
        case .failed:
            Color.red
        }
    }
}
