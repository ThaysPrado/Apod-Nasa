//
//  HomeViewModelTests.swift
//  APOD
//
//  Created by Thays Prado on 02/02/25.
//

import XCTest
import Combine

class HomeViewModelSuccessTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockService: MockApodService!
    var mockRepository: MockApodRepository!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockService = MockApodService()
        mockRepository = MockApodRepository()
        viewModel = HomeViewModel(service: mockService, repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockRepository = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func test_getAPOD_success() {
        XCTAssertTrue(viewModel.status.isLoading)
        viewModel.getAPOD()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.status, .success)
        }
    }
    
    func test_save_success() {
        viewModel.getAPOD()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            XCTAssertEqual(self.viewModel.status, .success)
            XCTAssertNotNil(self.viewModel.apod)

            let result = self.viewModel.save()
            XCTAssertTrue(result)
            XCTAssertTrue(self.mockRepository.didSave)
        }
    }
}
