//
//  EnvironmentProvider.swift
//  TMDB
//
//  Created by Bálna on 25/09/2024.
//

import Foundation

enum EnvironmentProvider {
    enum Environment: String {
        case production
        case mock
    }
    
    static var environment: Environment {
        get {
            let environmentValue = ProcessInfo.processInfo.environment["environment"]
            switch environmentValue {
            case "mock": return .mock
            default: return .production
            }
        }
    }
}
