//
//  MovieDetailsView.swift
//  TMDB
//
//  Created by Bálna on 06/01/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    private let viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text(viewModel.movie.title)
            Text(viewModel.movie.originalTitle)
            Text(viewModel.movie.overview)
        }
    }
}

//#Preview {
//    MovieDetailsView(viewModel: MovieDetailsViewModel(movieDetails: <#T##MovieListItem#>))
//}
