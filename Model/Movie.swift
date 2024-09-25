//
//  Movie.swift
//  Model
//
//  Created by Bálna on 25/09/2024.
//

import Foundation

public struct Movie: Identifiable {
    public let id: Int?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let title: String?
    
    public init(id: Int?,
                originalTitle: String?,
                overview: String?,
                popularity: Double?,
                title: String?) {
        self.id = id
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.title = title
    }
}
