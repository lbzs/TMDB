//
//  StreamingProvidersView.swift
//  Streamit
//
//  Created by Bálna on 01/02/2025.
//

import SwiftUI

struct StreamingProvidersView: View {
    @ObservedObject
    private var viewModel: StreamingProvidersViewModel

    init(viewModel: StreamingProvidersViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.providers) { (provider: WatchProvider) in
            StreamingProviderCell(viewModel: StreamingProviderCellViewModel(provider: provider))
        }
        .onAppear(perform: {
            viewModel.handle(action: .viewDidAppear)
        })
    }
}
