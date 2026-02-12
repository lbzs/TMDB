//
//  ImageService.swift
//  Streamit
//
//  Created by Bálna on 2026. 02. 12..
//

import Foundation
import UIKit
import SwiftUI

final actor ImageService {
    private let apiClient: ApiClientInterface
    private var cache = [URL: UIImage]()
    
    init(apiClient: ApiClientInterface) {
        self.apiClient = apiClient
    }
    
    func downloadImage(from url: URL?) async throws -> UIImage? {
        guard let url else { return nil }
        
        // return cached image
        if let image = cache[url] { return image }
        
        // download if needed
        let imageData = try await apiClient.downloadImageData(url: url)
        let image = UIImage(data: imageData)
        cache[url] = image
        
        return image
    }
    
    func downloadImage(from url: URL?) async throws -> Image? {
        guard let uiImage: UIImage = try await downloadImage(from: url) else { return nil }
        return Image(uiImage: uiImage)
    }
}
