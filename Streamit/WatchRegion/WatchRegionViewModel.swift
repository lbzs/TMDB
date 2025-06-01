//
//  WatchRegionViewModel.swift
//  Streamit
//
//  Created by Bálna on 27/01/2025.
//

import Combine

@MainActor
final class WatchRegionViewModel: ObservableObject {
    enum Action {
        case viewDidAppear
    }
    
    @Published
    private(set) var countries = [Country]()
    
    private let apiClient: ApiClientInterface
    
    init(apiClient: ApiClientInterface) {
        self.apiClient = apiClient
    }
    
    func handle(action: Action) {
        switch action {
        case .viewDidAppear:
            Task {
                countries = await Configuration.shared.countries
            }
        }
    }
}
