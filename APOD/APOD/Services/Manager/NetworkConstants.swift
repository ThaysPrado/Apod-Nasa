//
//  NetworkConst.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import Foundation

struct NetworkConstants {
    struct URLs {
        static var baseURL: URL {
            guard let url = URL(string: "https://api.nasa.gov/planetary/apod") else {
                fatalError("Error to convert string url to URL")
            }
            return url
        }
    }
}
