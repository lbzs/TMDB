//
//  StreamingProviderCellViewModel.swift
//  Streamit
//
//  Created by Bálna on 11/02/2025.
//

import Foundation
import SwiftUI

final class StreamingProviderCellViewModel: ObservableObject {
    @Published
    private(set) var providerName: String
    @Published
    private(set) var providerImage: Image?

    init(providerName: String, providerImageData: Data?) {
        self.providerName = providerName
        if let providerImageData,
           let uiImage = UIImage(data: providerImageData) {
            self.providerImage = Image(uiImage: uiImage)
        } else {
            self.providerImage = nil
        }
    }
}
