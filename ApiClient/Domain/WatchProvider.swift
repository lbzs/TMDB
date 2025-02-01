//
//  WatchProvider.swift
//  Streamit
//
//  Created by Bálna on 26/01/2025.
//

import Foundation

public struct WatchProvider: Identifiable {
    public let id: Int
    public let name: String
    public let logoPath: URL

    public init(id: Int, name: String, logoPath: URL) {
        self.id = id
        self.name = name
        self.logoPath = logoPath
    }
}
