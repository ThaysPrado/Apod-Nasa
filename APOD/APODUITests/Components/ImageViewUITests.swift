//
//  ImageViewUITests.swift
//  APOD
//
//  Created by Thays Prado on 03/02/25.
//

import XCTest
import ViewInspector

class ImageViewUITests: XCTestCase {
    
    func test_image_view_ui_correclty() throws {
        let sut = ImageView(url: "https://apod.nasa.gov/apod/image/2501/M33_1024.jpg")
        
        let container = try sut.inspect()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            do {
                let image = try container.find(viewWithId: "ImageView")
                XCTAssertNotNil(image)
            } catch {
                XCTFail("Failed to load image")
            }
        }
    }
}
