//
//  StreamingProviderCellViewModel.swift
//  Streamit
//
//  Created by Bálna on 11/02/2025.
//

import Foundation
import SwiftUI

@MainActor
final class StreamingProviderCellViewModel: ObservableObject {
    @Published
    private(set) var name: String
    @Published
    private(set) var image: Image? = nil
    
    private let imageService: ImageService
    private let url: URL?

    init(imageService: ImageService,
         data: StreamingProviderCell.Data) {
        self.imageService = imageService
        self.name = data.name
        self.url = data.url
    }
    
    func downloadImage() async {
        image = try? await imageService.downloadImage(from: url)
    }
}
