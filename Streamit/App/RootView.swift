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
    private let streaminProviderRepository: StreamingProviderRepository

    init(configurationManager: ConfigurationManager,
         streaminProviderRepository: StreamingProviderRepository) {
        self.configurationManager = configurationManager
        self.streaminProviderRepository = streaminProviderRepository
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
                    streaminProviderRepository: streaminProviderRepository
                ))
        case .failed:
            Color.red
        }
    }
}
