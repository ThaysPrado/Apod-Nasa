//
//  FullImageViewTests.swift
//  APOD
//
//  Created by Thays Prado on 02/02/25.
//
import SnapshotTesting
import XCTest

final class FullImageViewTests: XCTestCase {
    
    func testFullImageViewTestsSnapShot() {
        let sut = FullImageView(imageURL: "https://apod.nasa.gov/apod/image/2501/M33_1024.jpg")
        
        assertSnapshot(
            of: sut,
            as: .wait(for: 5, on: .image(
                precision: 0.9999,
                layout: .fixed(
                    width: UIScreen.main.bounds.size.width,
                    height: 1300)
            )),
            record: true
        )
    }
}
