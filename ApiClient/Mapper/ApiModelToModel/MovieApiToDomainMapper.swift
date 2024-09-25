//
//  MovieApiToDomainMapper.swift
//  ApiClient
//
//  Created by Bálna on 10/04/2024.
//

import Model

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
