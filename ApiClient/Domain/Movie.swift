//
//  Movie.swift
//  ApiClient
//
//  Created by Bálna on 07/01/2025.
//

import TMDb

public struct Movie: Identifiable, Hashable {
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
    
    internal init(apimodel: MovieListItem) {
        self.init(
            id: apimodel.id,
            title: apimodel.title,
            originalTitle: apimodel.originalTitle,
            originalLanguage: apimodel.originalLanguage,
            overview: apimodel.overview
        )
    }
}
