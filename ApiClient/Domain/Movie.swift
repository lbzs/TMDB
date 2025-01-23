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
    public let runtime: Int?
    
    public init(id: Int, title: String, runtime: Int?) {
        self.id = id
        self.title = title
        self.runtime = runtime
    }
    
    internal init(apiModel: TMDb.Movie) {
        self.init(
            id: apiModel.id,
            title: apiModel.title,
            runtime: apiModel.runtime
        )
    }
}
