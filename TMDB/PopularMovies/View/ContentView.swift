//
//  ContentView.swift
//  TMDB
//
//  Created by Bálna on 2024. 04. 09..
//

import SwiftUI
import ApiClient

struct ContentView: View {
    @ObservedObject
    private var viewModel: PopularMoviesViewModel
    
    init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(viewModel.movies) { (movie: Movie) in
            Text(movie.title ?? "dummy")
        }
        .onAppear(perform: {
            viewModel.handleAction(action: .viewDidAppear)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: PopularMoviesViewModel(apiClient: MockApiClient()))
    }
}
