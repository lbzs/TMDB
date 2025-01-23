//
//  ContentView.swift
//  TMDB
//
//  Created by Bálna on 2024. 04. 09..
//

import ApiClient

import SwiftUI

struct ContentView: View {
    @ObservedObject
    private var viewModel: PopularMoviesViewModel
    @State
    private var navigationStack: [MovieListItem] = []
    
    init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack(path: $navigationStack) {
            List(viewModel.movies) { (movie: MovieListItem) in
                NavigationLink(movie.title, value: movie)
            }
            .navigationDestination(for: MovieListItem.self) { (movie: MovieListItem) in
                MovieDetailsView(viewModel: MovieDetailsViewModel(apiClient: viewModel.apiClient, movieId: movie.id))
            }
            .onAppear(perform: {
                viewModel.handleAction(action: .viewDidAppear)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PopularMoviesViewModel(apiClient: MockApiClient()))
    }
}
