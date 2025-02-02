//
//  MockApodRepository.swift
//  APOD
//
//  Created by Thays Prado on 02/02/25.
//

import XCTest

final class MockApodRepository: ApodRepositoryProtocol {
    var shouldFetchReturnNil = true
    var didSave = false
    var didDelete = false
    
    func fetchAll() throws -> [Apod] {
        return [Apod(
            copyright: nil,
            thumbnailUrl: nil,
            date: "2024-01-01",
            explanation: "Test APOD",
            mediaType: .image,
            title: "",
            url: "https://example.com"
        )]
    }
    
    func fetch(byDate date: String) throws -> Apod? {
        return shouldFetchReturnNil ? nil : Apod(
            copyright: nil,
            thumbnailUrl: nil,
            date: "2024-01-01",
            explanation: "Test APOD",
            mediaType: .image,
            title: "",
            url: "https://example.com"
        )
    }
    
    func save(_ apod: Apod) throws {
        didSave = true
    }
    
    func delete(byDate date: String) throws {
        didDelete = true
    }
}
