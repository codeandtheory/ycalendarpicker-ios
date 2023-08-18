//
//  DayViewTests.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 02/12/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker
import SwiftUI

final class DayViewTests: XCTestCase {
    func testDateTextIsTodayDateText() {
        let sut = makeSUT()
        let dateText = sut.dateItem.day
        XCTAssertNotNil(dateText, Date().get(.day))
    }

    func testDateTextAppearanceForSelectedDate() {
        let sut = makeSUT(isSelected: true, appearance: .Defaults.selected)
        XCTAssertAppearanceEqual(appearance1: sut.appearance, appearance2: .Defaults.selected)
    }

    func testDateTextAppearanceForToday() {
        let sut = makeSUT(appearance: .Defaults.today)
        XCTAssertAppearanceEqual(appearance1: sut.appearance, appearance2: .Defaults.today)
    }

    func testDateTextAppearanceForCurrentMonth() {
        let previousDate = Date().previousDate()
        let sut = makeSUT(dateToTest: previousDate, appearance: .Defaults.normal)
        XCTAssertAppearanceEqual(appearance1: sut.appearance, appearance2: .Defaults.normal)
    }
    
    func testDateTextAppearanceForGrayOutDate() throws {
        let previousMonthDate = try XCTUnwrap(Calendar.current.date(byAdding: .month, value: -1, to: Date()))
        let sut = makeSUT(isGrayedOut: true, dateToTest: previousMonthDate, appearance: .Defaults.grayed)
        XCTAssertAppearanceEqual(appearance1: sut.appearance, appearance2: .Defaults.grayed)
    }
    
    func testDateTextAppearanceForNotEnabledDate() throws {
        let previousMonthDate = try XCTUnwrap(Calendar.current.date(byAdding: .month, value: -1, to: Date()))
        let sut = makeSUT(isEnabled: false, dateToTest: previousMonthDate, appearance: .Defaults.disabled)
        XCTAssertAppearanceEqual(appearance1: sut.appearance, appearance2: .Defaults.disabled)
    }
    
    func testDateTextAppearanceForBookedDates() {
        let sut = makeSUT(isBooked: true, appearance: .Defaults.booked)
        XCTAssertAppearanceEqual(appearance1: sut.appearance, appearance2: .Defaults.booked)
    }
    
    func testDateBodyPreviewisNotNil() {
        let sutPreview = DayView_Previews.previews
        XCTAssertNotNil(sutPreview)
    }

    func testGetAccessibilityText() throws {
        let previousMonthDate = try XCTUnwrap(Calendar.current.date(byAdding: .month, value: -1, to: Date()))
        let today = CalendarPicker.Strings.todayDayDescriptor.localized

        XCTAssertTrue(makeSUT().getAccessibilityText().hasSuffix(today))
        XCTAssertFalse(makeSUT(dateToTest: previousMonthDate).getAccessibilityText().hasSuffix(today))
    }
    
    func testGetAccessibilityTextForDifferentLocale() {
        let dateToTest = Date().previousDate().dateOnly
        let sut = makeSUT(dateToTest: dateToTest, locale: Locale(identifier: "pt_BR"))
        
        XCTAssertEqual(
            sut.getAccessibilityText(),
            dateToTest.toString(withTemplate: "dEEEEMMMM", locale: Locale(identifier: "pt_BR"))
        )
    }

    func testGetAccessibilityTraits() {
        XCTAssertEqual(makeSUT().getAccessibilityTraits(), .isButton)
        XCTAssertEqual(makeSUT(isSelected: true).getAccessibilityTraits(), .isSelected)
    }

    func testGetAccessibilityHint() {
        XCTAssertFalse(makeSUT().getAccessibilityHint().isEmpty)
        XCTAssertFalse(makeSUT(isGrayedOut: true).getAccessibilityHint().isEmpty)
        XCTAssertTrue(makeSUT(isSelected: true).getAccessibilityHint().isEmpty)
    }
}

private extension DayViewTests {
    func makeSUT(
        isGrayedOut: Bool = false,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        dateToTest: Date = Date(),
        locale: Locale? = nil,
        isBooked: Bool = false,
        appearance: CalendarPicker.Appearance.Day = .Defaults.normal
    ) -> DayView {
        let dateItem = dateToTest.toCalendarItem(
            isGrayedOut: isGrayedOut,
            isSelected: isSelected,
            isEnabled: isEnabled,
            isBooked: isBooked
        )
        let sut = DayView(
            appearance: appearance,
            dateItem: dateItem,
            locale: locale ?? Locale.current,
            selectedDate: .constant(Date())
        )
        XCTAssertNotNil(sut.body)
        return sut
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
