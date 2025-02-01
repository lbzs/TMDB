//
//  Configuration.swift
//  Streamit
//
//  Created by Bálna on 27/01/2025.
//

import Foundation

public final class Configuration {
    public var countries: [Country]
    public var imageConfiguration: ImageConfiguration

    private init() {
        self.countries = []
        self.imageConfiguration = ImageConfiguration()
    }
    
    public static var shared = Configuration()
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
