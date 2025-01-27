//
//  Configuration.swift
//  Streamit
//
//  Created by Bálna on 27/01/2025.
//

import Foundation

public final class Configuration {
    public var countries: [Country]
    
    private init() {
        self.countries = []
    }
    
    public static var shared = Configuration()
}
