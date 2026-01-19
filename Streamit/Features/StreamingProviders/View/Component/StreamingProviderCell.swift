//
//  StreamingProviderCell.swift
//  Streamit
//
//  Created by Bálna on 11/02/2025.
//

import SwiftUI

struct StreamingProviderCell: View {
    var data: Data

    var body: some View {
        HStack {
            Group {
                if let image = data.image {
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

            Text(data.name)
        }
    }
}

// MARK: - Data
extension StreamingProviderCell {
    struct Data: Identifiable {
        let id = UUID()
        let name: String
        let url: URL?
        var image: Image?
    }
}
