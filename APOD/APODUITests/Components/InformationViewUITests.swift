//
//  InformationViewUITests.swift
//  APOD
//
//  Created by Thays Prado on 03/02/25.
//

import XCTest
import ViewInspector

class InformationViewUITests: XCTestCase {

    func test_information_view_correclty() throws {
        let sut = InformationView(title: "Galaxy",
                                  explanation: "Lorem ipsum",
                                  date: "2025-01-30",
                                  copyright: "Nasa Lorem ipsum",
                                  url: "http://",
                                  isFavorited: false,
                                  action: {},
                                  isSheetPresented: false)
        
        let container = try sut.inspect()
        
        let vstack = try container.find(ViewType.VStack.self)
        XCTAssertNotNil(vstack)
        
        let copyright = try container.find(viewWithId: "CopyrightText")
        XCTAssertNotNil(copyright)
        let copyrightText = try copyright.text().string()
        XCTAssertEqual(copyrightText, "Nasa Lorem ipsum")
        
        let date = try container.find(viewWithId: "DateText")
        XCTAssertNotNil(date)
        
        let title = try container.find(viewWithId: "TitleText")
        XCTAssertNotNil(title)
        let titleText = try title.text().string()
        XCTAssertEqual(titleText, "Galaxy")
        
        let explanation = try container.find(viewWithId: "ExplanationText")
        XCTAssertNotNil(explanation)
        let explanationText = try explanation.text().string()
        XCTAssertEqual(explanationText, "Lorem ipsum")
        
        let like = try container.find(viewWithId: "LikeButton")
        XCTAssertNotNil(like)
    }
}
