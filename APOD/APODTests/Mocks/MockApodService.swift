//
//  MockApodService.swift
//  APOD
//
//  Created by Thays Prado on 02/02/25.
//

import XCTest

struct MockApodService: ApodServiceProtocol {
    var result: Result<Apod, RequestError>?
    
    func getAPOD(_ date: Date?, _ completion: @escaping (Result<Apod, RequestError>) -> Void) {
        let apod = Apod(
            copyright: nil,
            thumbnailUrl: nil,
            date: "2024-01-01",
            explanation: "Test APOD explanation",
            mediaType: .image,
            title: "Test APOD",
            url: "https://example.com"
        )
        completion(.success(apod))
    }
}
