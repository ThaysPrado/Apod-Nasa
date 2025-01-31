//
//  ApodModel.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import Foundation

struct Apod: Decodable {
    let copyright: String
    let date: String
    let explanation: String
    let mediaType: MediaType
    let title: String
    let url: String

    enum MediaType: String, Decodable {
        case image
        case video
    }

    enum CodingKeys: String, CodingKey {
        case copyright
        case date
        case explanation
        case mediaType = "media_type"
        case title
        case url
    }
}
