//
//  ApodServiceTests.swift
//  APOD
//
//  Created by Thays Prado on 30/01/25.
//

import XCTest

final class ApodServiceTests: XCTestCase {
    
    func testGetAPODSuccess() {
        let mockJSON = """
        {
            "title": "Test Title",
            "explanation": "Test Explanation",
            "url": "https://example.com/image.jpg",
            "media_type": "image",
            "date": "2025-01-30",
            "copyright": "NASA"
        }
        """

        let mockData = mockJSON.data(using: .utf8)!
        let mockAPIManager = MockAPIManager()

        let mockApod = try? JSONDecoder().decode(Apod.self, from: mockData)
        mockAPIManager.responseResult = Result<Apod, RequestError>.success(mockApod!)

        let service = ApodService(apiManager: mockAPIManager)
        let expectation = XCTestExpectation(description: "Get APOD success")
        service.getAPOD { result in
            switch result {
            case .success(let apod):
                XCTAssertEqual(apod.title, "Test Title")
                XCTAssertEqual(apod.explanation, "Test Explanation")
                XCTAssertEqual(apod.url, "https://example.com/image.jpg")
                XCTAssertEqual(apod.date, "2025-01-30")
                XCTAssertEqual(apod.copyright, "NASA")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success, but got error: \(error)")
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testGetAPODError() {
        let mockAPIManager = MockAPIManager()
        mockAPIManager.responseResult = Result<Apod, RequestError>.failure(.networkError)

        let service = ApodService(apiManager: mockAPIManager)
        let expectation = XCTestExpectation(description: "Get APOD failure")
        service.getAPOD { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual(error, RequestError.networkError)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
