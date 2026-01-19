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
        List(viewModel.listItems) { (provider: StreamingProviderCell.Data) in
            StreamingProviderCell(data: provider)
                .onAppear(perform: {
                    viewModel.handle(action: .downloadImage(url: provider.url))
                })
        }
        .onAppear(perform: {
            viewModel.observe()
            viewModel.handle(action: .viewDidAppear)
        })
    }
}
