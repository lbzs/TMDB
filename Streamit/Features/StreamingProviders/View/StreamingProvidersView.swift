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
    private var imageService: ImageService

    init(
        viewModel: StreamingProvidersViewModel,
        imageService: ImageService
    ) {
        self.viewModel = viewModel
        self.imageService = imageService
    }

    var body: some View {
        content
            .onAppear(perform: {
                viewModel.handle(action: .viewDidAppear)
            })
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .initial:
            Color.green
            
        case .loading:
            ProgressView()
            
        case .loaded(let data):
            List(data) { (provider: StreamingProviderCell.Data) in
                let cellViewModel = StreamingProviderCellViewModel(
                    imageService: imageService,
                    data: provider
                )
                return StreamingProviderCell(viewModel: cellViewModel)
            }
    
        case .failed:
            Color.red
        }
    }
}
