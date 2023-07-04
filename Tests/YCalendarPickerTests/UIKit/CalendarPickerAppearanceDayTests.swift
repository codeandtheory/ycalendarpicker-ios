//
//  CalendarPickerAppearanceDayTests.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 14/12/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class CalendarPickerAppearanceDayTests: XCTestCase {
    func testDefaultDayNotNil() {
        let sut = CalendarPicker.Appearance.Day()
        XCTAssertNotNil(sut.typography)
        XCTAssertNotNil(sut.foregroundColor)
        XCTAssertNotNil(sut.backgroundColor)
        XCTAssertNotNil(sut.borderColor)
        XCTAssertNotNil(sut.borderWidth)
    }
    
    func testDefaultDayValues() {
        let sut = CalendarPicker.Appearance.Day()
        XCTAssertTypographyEqual(sut.typography, .day)
        XCTAssertEqual(sut.foregroundColor, UIColor.label)
        XCTAssertEqual(sut.backgroundColor, UIColor.clear)
        XCTAssertEqual(sut.borderColor, UIColor.clear)
        XCTAssertEqual(sut.borderWidth, 1.0)
    }

    func testHiddenAppearance() {
        let sut = CalendarPicker.Appearance.Day(isHidden: true)
        XCTAssertTypographyEqual(sut.typography, .day)
        XCTAssertEqual(sut.foregroundColor, UIColor.clear)
        XCTAssertEqual(sut.backgroundColor, UIColor.clear)
        XCTAssertEqual(sut.borderColor, UIColor.clear)
        XCTAssertEqual(sut.borderWidth, 1.0)
    }
}
