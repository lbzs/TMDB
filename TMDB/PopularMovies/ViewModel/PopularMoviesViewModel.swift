//
//  PopularMoviesViewModel.swift
//  TMDB
//
//  Created by Bálna on 22/09/2024.
//

import ApiClient
import TMDb

import Combine

@MainActor
final class PopularMoviesViewModel: ObservableObject {
    enum Action {
        case viewDidAppear
        case itemDidSelect(MovieListItem)
    }
    
    @Published 
    var movies = [MovieListItem]()
    
    private let apiClient: ApiClientInterface
    private let coordinator: 
    
    init(apiClient: ApiClientInterface) {
        self.apiClient = apiClient
    }
    
    func handleAction(action: Action) {
        switch action {
        case .viewDidAppear:
            Task {
                movies = try await apiClient.popularMovies()
            }
        case .itemDidSelect(let movieDetails):
            
        }
    }
}
