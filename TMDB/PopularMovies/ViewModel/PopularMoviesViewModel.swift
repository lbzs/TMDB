//
//  PopularMoviesViewModel.swift
//  TMDB
//
//  Created by Bálna on 22/09/2024.
//

import ApiClient
import Model

import Combine

@MainActor
final class PopularMoviesViewModel: ObservableObject {
    enum Action {
        case viewDidAppear
    }
    
    @Published 
    var movies = [Movie]()
    
    private let apiClient: ApiClientInterface
    
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
