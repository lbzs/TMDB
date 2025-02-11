//
//  StreamingProviderCell.swift
//  Streamit
//
//  Created by Bálna on 11/02/2025.
//

import SwiftUI

struct StreamingProviderCell: View {

    @ObservedObject
    var viewModel: StreamingProviderCellViewModel

    var body: some View {
        HStack {
            AsyncImage(url: viewModel.provider.logoURL!) { (image: Image) in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .aspectRatio(contentMode: .fit)
            .clipShape(.buttonBorder)

            Text(viewModel.provider.name)
        }
    }
}
