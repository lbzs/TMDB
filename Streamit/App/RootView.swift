//
//  RootView.swift
//  Streamit
//
//  Created by Bálna on 2025. 12. 12..
//

import Foundation
import SwiftUI

struct RootView: View {
    @ObservedObject private var configurationManager: ConfigurationManager
    private let streamingProviderRepository: StreamingProviderRepository

    init(configurationManager: ConfigurationManager,
         streamingProviderRepository: StreamingProviderRepository) {
        self.configurationManager = configurationManager
        self.streamingProviderRepository = streamingProviderRepository
    }

    var body: some View {
        switch configurationManager.state {
        case .initial:
            Color.green
                .onAppear {
                    Task.detached {
                        await configurationManager.loadConfiguration()
                    }
                }
        case .loading:
            ProgressView()
        case .loaded:
            StreamingProvidersView(
                viewModel: StreamingProvidersViewModel(
                    streamingProviderRepository: streamingProviderRepository
                ))
        case .failed:
            Color.red
        }
    }
}
