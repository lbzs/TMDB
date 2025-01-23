//
//  MovieDetailsViewModel.swift
//  TMDB
//
//  Created by Bálna on 06/01/2025.
//

import ApiClient

@MainActor
final class MovieDetailsViewModel: ObservableObject {
    enum Action {
        case viewDidAppear
    }

    @Published
    private(set) var movie: Movie?
    
    private let apiClient: ApiClientInterface
    private let movieId: Int
    
    init(apiClient: ApiClientInterface, movieId: Int) {
        self.apiClient = apiClient
        self.movieId = movieId
    }
    
    func handleAction(action: Action) {
        switch action {
        case .viewDidAppear:
            Task {
                movie = try await apiClient.movieDetails(movieId: movieId)
            }
        }
    }
}
