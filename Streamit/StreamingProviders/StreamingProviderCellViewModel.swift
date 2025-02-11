//
//  StreamingProviderCellViewModel.swift
//  Streamit
//
//  Created by Bálna on 11/02/2025.
//

import Foundation

final class StreamingProviderCellViewModel: ObservableObject {
    @Published
    private(set) var provider: WatchProvider

    init(provider: WatchProvider) {
        self.provider = provider
    }
}
