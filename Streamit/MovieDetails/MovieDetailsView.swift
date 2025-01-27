//
//  MovieDetailsView.swift
//  TMDB
//
//  Created by Bálna on 06/01/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject
    private var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if let movie = viewModel.movie {
            VStack {
                Text(movie.title)
                Text("\(movie.runtime) minutes")
            }
        } else {
            ProgressView("Loading...")
        }
    }
}

//#Preview {
//    MovieDetailsView(viewModel: MovieDetailsViewModel(movieDetails: <#T##MovieListItem#>))
//}
