//
//  CalendarMonthItemTests.swift
//  YCalendarPicker
//
//  Created by Mark Pospesel on 1/26/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class CalendarMonthItemTests: XCTestCase {
    func test_init_populatesComponents() throws {
        let now = try makeDate(for: "1947-01-08")
        let sut = now.toCalendarItem()

        XCTAssertEqual(sut.day, "8")
        XCTAssertEqual(sut.month, "1")
        XCTAssertEqual(sut.year, "1947")
    }

    func test_init_removesTime() {
        let now = Date()
        let sut = now.toCalendarItem()

        XCTAssertEqual(sut.date, now.dateOnly)
    }

    func test_isSelectable() {
        let now = Date()
        let enabledBooked = now.toCalendarItem(isEnabled: true, isBooked: true)
        let disabledBooked = now.toCalendarItem(isEnabled: false, isBooked: true)
        let enabledUnbooked = now.toCalendarItem(isEnabled: true, isBooked: false)
        let disabledUnbooked = now.toCalendarItem(isEnabled: false, isBooked: false)

        XCTAssertFalse(enabledBooked.isSelectable)
        XCTAssertFalse(disabledBooked.isSelectable)
        XCTAssertTrue(enabledUnbooked.isSelectable)
        XCTAssertFalse(disabledUnbooked.isSelectable)
    }
}

private extension CalendarMonthItemTests {
    func makeDate(for dateString: String) throws -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return try XCTUnwrap(dateFormatter.date(from: dateString))
    }
}
