//
//  PopularMoviesViewModel.swift
//  TMDB
//
//  Created by Bálna on 22/09/2024.
//

import ApiClient

import Combine
import SwiftUI

@MainActor
final class PopularMoviesViewModel: ObservableObject {
    enum Action {
        case viewDidAppear
    }
    
    @Published 
    var movies = [MovieListItem]()
    
    let apiClient: ApiClientInterface
    
    init(apiClient: ApiClientInterface) {
        self.apiClient = apiClient
    }
    
    func handleAction(action: Action) {
        switch action {
        case .viewDidAppear:
            Task {
                movies = try await apiClient.popularMovies()
            }
        }
    }
}
