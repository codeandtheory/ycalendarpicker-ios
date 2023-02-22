//
//  Date+onlyDateTests.swift
//  YCalendarPicker
//
//  Created by Mark Pospesel on 12/14/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCalendarPicker

final class DateOnlyDateTests: XCTestCase {
    func testDateOnlyHasCorrectDate() throws {
        let date = try XCTUnwrap(makeDate())
        let sut = date.dateOnly

        let comp1 = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let comp2 = Calendar.current.dateComponents([.year, .month, .day], from: sut)

        XCTAssertEqual(comp1.year, comp2.year)
        XCTAssertEqual(comp1.month, comp2.month)
        XCTAssertEqual(comp1.day, comp2.day)
    }

    func testDateOnlyHasNoTime() throws {
        let date = try XCTUnwrap(makeDate())
        let sut = date.dateOnly

        let components = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: sut)

        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
        XCTAssertEqual(components.nanosecond, 0)
    }
}

private extension DateOnlyDateTests {
    func makeDate() -> Date? {
        Date()
            .date(byAddingMonth: Int.random(in: -6...6))?
            .date(byAddingDays: Int.random(in: -15...15))
    }
}
