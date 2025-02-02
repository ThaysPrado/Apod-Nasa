//
//  StringExtensionTests.swift
//  APOD
//
//  Created by Thays Prado on 02/02/25.
//

import XCTest

class DateFormatterTests: XCTestCase {

    func testToStringWithCustomFormat() {
        let testDate = Date(timeIntervalSince1970: 1738526465)
        
        let expectedString = "02/02/2025"
        
        let result = testDate.toString(format: "dd/MM/yyyy")
        XCTAssertEqual(result, expectedString, "Data formated 'dd/MM/yyyy' should be equal '02/02/2025'")
    }

    
    func testToStringWithEmptyFormat() {
        let testDate = Date(timeIntervalSince1970: 1738526465)
        
        let expectedString = "2025-02-02"
        
        let result = testDate.toString()
        XCTAssertEqual(result, expectedString, "Data format 'yyyy-MM-dd'")
    }
}
