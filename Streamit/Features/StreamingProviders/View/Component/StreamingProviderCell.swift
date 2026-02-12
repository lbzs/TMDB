//
//  StreamingProviderCell.swift
//  Streamit
//
//  Created by Bálna on 11/02/2025.
//

import SwiftUI

struct StreamingProviderCell: View {
    @ObservedObject
    private var viewModel: StreamingProviderCellViewModel
    
    init(viewModel: StreamingProviderCellViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            Group {
                if let image = viewModel.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 50, height: 50)
            .aspectRatio(contentMode: .fit)
            .clipShape(.buttonBorder)

            Text(viewModel.name)
        }
        .task {
            await viewModel.downloadImage()
        }
    }
}

// MARK: - Data
extension StreamingProviderCell {
    struct Data: Identifiable {
        let id = UUID()
        let name: String
        let url: URL?
    }
}
