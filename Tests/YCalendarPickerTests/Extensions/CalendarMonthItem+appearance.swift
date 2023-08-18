//
//  CalendarMonthItemAppearance.swift
//  YCalendarTest
//
//  Created by Sahil Saini on 18/08/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class CalendarMonthItemAppearance: XCTestCase {
    func testDateTextAppearanceForSelectedDate() {
        let sut = makeSUT(isSelected: true)
        XCTAssertAppearanceEqual(appearance1: sut, appearance2: .Defaults.selected)
    }

    func testDateTextAppearanceForToday() {
        let sut = makeSUT(isToday: true)
        XCTAssertAppearanceEqual(appearance1: sut, appearance2: .Defaults.today)
    }

    func testDateTextAppearanceForBookedDate() {
        let sut = makeSUT(isBooked: true)
        XCTAssertAppearanceEqual(appearance1: sut, appearance2: .Defaults.booked)
    }

    func testDateTextAppearanceForGrayedDate() {
        let sut = makeSUT(isGrayedOut: true, dateToTest: Date().previousDate())
        XCTAssertAppearanceEqual(appearance1: sut, appearance2: .Defaults.grayed)
    }

    func testDateTextAppearanceForDisabledGrayedDate() {
        let sut = makeSUT(isGrayedOut: true, isEnabled: false, dateToTest: Date().previousDate())
        XCTAssertAppearanceEqual(appearance1: sut, appearance2: .Defaults.grayed)
    }

    func testDateTextAppearanceForDisabledDate() {
        let sut = makeSUT(isEnabled: false, dateToTest: Date().previousDate())
        XCTAssertAppearanceEqual(appearance1: sut, appearance2: .Defaults.disabled)
    }
}

extension CalendarMonthItemAppearance {
    func makeSUT(
        isToday: Bool = false,
        isGrayedOut: Bool = false,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        dateToTest: Date = Date(),
        isBooked: Bool = false
    ) -> CalendarPicker.Appearance.Day {
        let dateItem = dateToTest.toCalendarItem(
            isGrayedOut: isGrayedOut,
            isSelected: isSelected,
            isEnabled: isEnabled,
            isBooked: isBooked
        )

        return dateItem.getDayAppearance(from: .default)
    }

    func XCTAssertAppearanceEqual(
        appearance1: CalendarPicker.Appearance.Day,
        appearance2: CalendarPicker.Appearance.Day
    ) {
        XCTAssertTypographyEqual(appearance1.typography, appearance2.typography)
        XCTAssertEqual(appearance1.borderWidth, appearance2.borderWidth)
        XCTAssertEqual(appearance1.borderColor, appearance2.borderColor)
        XCTAssertEqual(appearance1.backgroundColor, appearance2.backgroundColor)
        XCTAssertEqual(appearance1.foregroundColor, appearance2.foregroundColor)
    }
}
