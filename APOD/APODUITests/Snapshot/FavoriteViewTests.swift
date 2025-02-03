//
//  FavoriteViewTests.swift
//  APOD
//
//  Created by Thays Prado on 03/02/25.
//

import XCTest
import SnapshotTesting

final class FavoriteViewTests: XCTestCase {
    
    func test_favorite_view_snapshot() {
        let sut = FavoriteView(viewModel: FavoriteViewModel(repository: MockApodRepository()))
        
        assertSnapshot(
            of: sut,
            as: .wait(for: 5, on: .image(
                precision: 0.9999,
                layout: .fixed(
                    width: UIScreen.main.bounds.size.width,
                    height: 600)
            )),
            record: false
        )
    }
}
