//
//  ErrorViewUITests.swift
//  APOD
//
//  Created by Thays Prado on 02/02/25.
//

import XCTest
import SwiftUI

final class ErrorViewUITests: XCTestCase {

    private var app: XCUIApplication!
    private var UIs: ErrorView!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        UIs = ErrorView(title: "Title", message: "Message")
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func test_error_view_properties() {
        XCTAssertEqual(UIs.message, "Message")
        XCTAssertEqual(UIs.title, "Title")
    }
    
    func test_show_error_view_correctly() {
        let titleText = app.staticTexts["titleText"]
        let messageText = app.staticTexts["messageText"]
        
        XCTAssertTrue(titleText.waitForExistence(timeout: 5))
        XCTAssertTrue(messageText.waitForExistence(timeout: 5))
    }

}
