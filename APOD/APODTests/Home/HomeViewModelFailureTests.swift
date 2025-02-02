//
//  HomeViewModelFailureTests.swift
//  APOD
//
//  Created by Thays Prado on 02/02/25.
//

import XCTest
import Combine

class HomeViewModelFailureTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockService: MockApodService!
    var mockRepository: MockApodRepository!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockService = MockApodService()
        mockRepository = MockApodRepository(false)
        viewModel = HomeViewModel(service: mockService, repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockRepository = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func test_getAPOD_failure() {
        XCTAssertTrue(viewModel.status.isLoading)
        viewModel.getAPOD()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.status, .failure)
        }
    }
}
