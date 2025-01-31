//
//  ServiceConfig.swift
//  APOD
//
//  Created by Thays Prado on 29/01/25.
//

import Foundation

struct ServiceConfig {
    static func getApiKey() -> String {
        if let apikey = ProcessInfo.processInfo.environment["API_KEY"] {
            return apikey
        } else {
            return ""
        }
    }
}

