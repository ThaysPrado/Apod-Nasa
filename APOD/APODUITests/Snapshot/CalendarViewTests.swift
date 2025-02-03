//
//  CalendarViewTests.swift
//  APOD
//
//  Created by Thays Prado on 03/02/25.
//

import XCTest
import SnapshotTesting

final class CalendarViewTests: XCTestCase {
    
    func test_calendar_view_snapshot() {
        let sut = CalendarView(selectedDate: .constant(Date()), isPresented: .constant(true))
        
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
