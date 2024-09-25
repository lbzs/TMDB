//
//  MovieApiToDomainMapper.swift
//  ApiClient
//
//  Created by Bálna on 10/04/2024.
//

import Foundation

struct MovieApiToDomainMapper {
    func map(from apiModel: Operations.movie_hyphen_popular_hyphen_list.Output.Ok.Body.jsonPayload.resultsPayload) -> [Movie] {
        return apiModel.map { model in
            Movie(
                id: model.id,
                originalTitle: model.original_title,
                overview: model.overview,
                popularity: model.popularity,
                title: model.title
            )
        }
    }
    
    func map(from apiModel: Operations.movie_hyphen_now_hyphen_playing_hyphen_list.Output.Ok.Body.jsonPayload.resultsPayload) -> [Movie] {
        return apiModel.map { model in
            Movie(
                id: model.id,
                originalTitle: model.original_title,
                overview: model.overview,
                popularity: model.popularity,
                title: model.title
            )
        }
    }
    
    func map(from apiModel: Operations.movie_hyphen_upcoming_hyphen_list.Output.Ok.Body.jsonPayload.resultsPayload) -> [Movie] {
        return apiModel.map { model in
            Movie(
                id: model.id,
                originalTitle: model.original_title,
                overview: model.overview,
                popularity: model.popularity,
                title: model.title
            )
        }
    }
}

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
