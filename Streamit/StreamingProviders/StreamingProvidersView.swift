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
            HStack {
                AsyncImage(url: viewModel.logoURLs[provider.id]) { (image: Image) in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
                .clipShape(.buttonBorder)

                Text(provider.name)
            }
        }
        .onAppear(perform: {
            viewModel.handle(action: .viewDidAppear)
        })
    }
}
