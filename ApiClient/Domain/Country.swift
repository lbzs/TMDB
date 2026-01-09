//
//  Country.swift
//  Streamit
//
//  Created by Bálna on 27/01/2025.
//

import Foundation

public struct Country: Sendable {
    public let id: String
    public let countryCode: String
    public let name: String
    public let englishName: String
    
    public init(id: String,
                countryCode: String,
                name: String,
                englishName: String) {
        self.id = id
        self.countryCode = countryCode
        self.name = name
        self.englishName = englishName
    }
}
