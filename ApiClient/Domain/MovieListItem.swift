//
//  MovieListItem.swift
//  ApiClient
//
//  Created by Bálna on 23/01/2025.
//

import TMDb

public struct MovieListItem: Identifiable, Hashable, Sendable {
    public let id: Int
    public let title: String
    public let originalTitle: String
    public let originalLanguage: String
    public let overview: String
    
    public init(id: Int, title: String, originalTitle: String, originalLanguage: String, overview: String) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
    }
    
    internal init(apiModel: TMDb.MovieListItem) {
        self.init(
            id: apiModel.id,
            title: apiModel.title,
            originalTitle: apiModel.originalTitle,
            originalLanguage: apiModel.originalLanguage,
            overview: apiModel.overview
        )
    }
}
