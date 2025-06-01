//
//  Configuration.swift
//  Streamit
//
//  Created by Bálna on 27/01/2025.
//

import Foundation

public actor Configuration {
    public var countries: [Country]
    public var imageConfiguration: ImageConfiguration

    private init() {
        self.countries = []
        self.imageConfiguration = ImageConfiguration()
    }
    
    public static var shared = Configuration()

    public func update(countries: [Country]) {
        self.countries = countries
    }

    public func update(imageConfiguration: ImageConfiguration) {
        self.imageConfiguration = imageConfiguration
    }
}

public struct ImageConfiguration {
    public let secureBaseURL: URL?
    public let logoSizes: [String]

    public init(secureBaseURL: URL?, logoSizes: [String]) {
        self.secureBaseURL = secureBaseURL
        self.logoSizes = logoSizes
    }

    public init() {
        self.init(secureBaseURL: nil, logoSizes: [])
    }
}
