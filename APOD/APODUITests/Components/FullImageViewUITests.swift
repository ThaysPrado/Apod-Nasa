//
//  FullImageViewUITests.swift
//  APOD
//
//  Created by Thays Prado on 03/02/25.
//

import XCTest
import ViewInspector

class FullImageViewUITests: XCTestCase {
    
    func test_full_image_view_ui_correclty() throws {
        let sut = FullImageView(imageURL: "https://apod.nasa.gov/apod/image/2501/M33_1024.jpg")
        
        let container = try sut.inspect()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            do {
                let image = try container.find(viewWithId: "FullImageView")
                XCTAssertNotNil(image)
            } catch {
                XCTFail("Failed to load image")
            }
        }
    }
}
