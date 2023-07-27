//
//  Date+dateWithTime.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 27/07/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCalendarPicker

final class DateWithTime: XCTestCase {
    func testDateWithTimeHasCorrectDate() throws {
        let date = try XCTUnwrap(makeDate())
        guard let sut = date.dateWithTime else {
            XCTFail("Unable to get date with time")
            return
        }

        let comp1 = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let comp2 = Calendar.current.dateComponents([.year, .month, .day], from: sut)

        XCTAssertEqual(comp1.year, comp2.year)
        XCTAssertEqual(comp1.month, comp2.month)
        XCTAssertEqual(comp1.day, comp2.day)
    }

    func testDateOnlyHasNoTime() throws {
        let date = try XCTUnwrap(makeDate())
        guard let sut = date.dateWithTime else {
            XCTFail("Unable to get date with time")
            return
        }
        let timeDate = Date()

        let components = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: sut)
        let expectedComponents = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: timeDate)

        XCTAssertEqual(components.hour, expectedComponents.hour)
        XCTAssertEqual(components.minute, expectedComponents.minute)
        XCTAssertEqual(components.second, expectedComponents.second)
        XCTAssertEqual(components.nanosecond, 0)
    }
}

private extension DateWithTime {
    func makeDate() -> Date? {
        Date()
            .date(byAddingMonth: Int.random(in: -6...6))?
            .date(byAddingDays: Int.random(in: -15...15))
    }
}
