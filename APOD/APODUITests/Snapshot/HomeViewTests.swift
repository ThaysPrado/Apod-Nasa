//
//  HomeViewTests.swift
//  APOD
//
//  Created by Thays Prado on 03/02/25.
//

import XCTest
import SnapshotTesting

final class HomeViewTests: XCTestCase {
    
    func test_home_view_snapshot() {
        let sut = HomeView()
        
        assertSnapshot(
            of: sut,
            as: .wait(for: 5, on: .image(
                precision: 0.9999,
                layout: .fixed(
                    width: UIScreen.main.bounds.size.width,
                    height: 800)
            )),
            record: false
        )
    }
}
