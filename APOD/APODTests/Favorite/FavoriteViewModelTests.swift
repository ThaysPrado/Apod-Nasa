//
//  FavoriteViewModelTests.swift
//  APOD
//
//  Created by Thays Prado on 02/02/25.
//

import XCTest
import Combine

class FavoriteViewModelTests: XCTestCase {
    
    func test_fetchAll_success() {
        let mockRepository = MockApodRepository()
        let viewModel = FavoriteViewModel(repository: mockRepository)
        
        XCTAssertEqual(viewModel.status, .initial)
        XCTAssertNil(viewModel.apods)

        viewModel.fetchAll()

        XCTAssertEqual(viewModel.status, .success)
        XCTAssertNotNil(viewModel.apods)
        XCTAssertEqual(viewModel.apods?.count, 1)
        XCTAssertEqual(viewModel.apods?.first?.date, "2024-01-01")
    }
    
    func test_fetchAll_failure() {
        let mockRepository = MockApodRepository()
        mockRepository.shouldFetchReturnNil = false
        
        let viewModel = FavoriteViewModel(repository: mockRepository)

        XCTAssertEqual(viewModel.status, .initial)
        XCTAssertNil(viewModel.apods)

        viewModel.fetchAll()

        XCTAssertEqual(viewModel.status, .success)
        XCTAssertNotNil(viewModel.apods)
    }
    
    func test_delete_success() {
        let mockRepository = MockApodRepository()
        let viewModel = FavoriteViewModel(repository: mockRepository)

        let result = viewModel.delete(byDate: "2024-01-01")

        XCTAssertTrue(result)
        XCTAssertTrue(mockRepository.didDelete)
    }
}
