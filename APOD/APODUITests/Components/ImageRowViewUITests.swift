//
//  ImageRowViewUITests.swift
//  APOD
//
//  Created by Thays Prado on 03/02/25.
//

import XCTest
import ViewInspector

class ImageRowViewUITests: XCTestCase {
    
    func test_full_image_view_ui_correclty() throws {
        let sut = ImageRowView(
            url: "https://apod.nasa.gov/apod/image/2501/M33_1024.jpg",
            thumbnailUrl: "",
            date: "2025-02-01",
            title: "Galaxy"
        )
        
        let container = try sut.inspect()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            do {
                let image = try container.find(viewWithId: "ImageRowView")
                XCTAssertNotNil(image)
                
                let title = try container.find(viewWithId: "ImageRowTitleText")
                XCTAssertNotNil(title)
                let titleText = try title.text().string()
                XCTAssertEqual(titleText, "Galaxy")
            } catch {
                XCTFail("Failed to load image")
            }
        }
    }
}
