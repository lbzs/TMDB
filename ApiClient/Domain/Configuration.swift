//
//  Configuration.swift
//  Streamit
//
//  Created by Bálna on 27/01/2025.
//

import Foundation

public struct Configuration: Sendable {
    public let countries: [Country]
    public let imageConfiguration: ImageConfiguration

    public init(countries: [Country],
                imageConfiguration: ImageConfiguration) {
        self.countries = countries
        self.imageConfiguration = imageConfiguration
    }
}

public struct ImageConfiguration: Sendable {
    public let secureBaseURL: URL
    public let logoSizes: [String]

    public init(secureBaseURL: URL, logoSizes: [String]) {
        self.secureBaseURL = secureBaseURL
        self.logoSizes = logoSizes
    }
}
