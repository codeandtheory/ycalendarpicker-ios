//
//  CalendarPicker+StringsTests.swift
//  YCalendarPicker
//
//  Created by Mark Pospesel on 1/13/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCoreUI
@testable import YCalendarPicker

final class CalendarPickerStringsTests: XCTestCase {
    func testLoad() {
        CalendarPicker.Strings.allCases.forEach {
            // Given a localized string constant
            let string = $0.localized
            // it should not be empty
            XCTAssertFalse(string.isEmpty)
            // and it should not equal its key
            XCTAssertNotEqual($0.rawValue, string)
        }
    }
}
