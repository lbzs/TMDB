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
    private var navigationStack: [Movie] = []
    
    init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack(path: $navigationStack) {
            List(viewModel.movies) { (movie: Movie) in
                NavigationLink(movie.title, value: movie)
            }
            .navigationDestination(for: Movie.self) { (movie: Movie) in
                MovieDetailsView(viewModel: MovieDetailsViewModel(movie: movie))
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
