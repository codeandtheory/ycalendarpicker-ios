//
//  WeekdayViewTests.swift
//  YCalendarPicker
//
//  Created by Sahil on 16/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class WeekdayViewTests: XCTestCase {
    func testWeekdayBodyisNotNil() {
        XCTAssertNotNil(makeSUT().body)
    }
    
    func testWeekdayViewIsNotNill() {
        XCTAssertNotNil(makeSUT().getWeekdayView())
    }
    
    func testWeekdayTextIsNotNill() {
        XCTAssertNotNil(makeSUT().getWeekText(for: 0))
    }
    
    func testWeekdayArrayIsNotNill() {
        XCTAssertNotNil(makeSUT().weekdayNames)
    }
    
    func testWeekdayBodyPreviewisNotNil() {
        XCTAssertNotNil(WeekdayView_Previews.previews)
    }
    
    func testWeekdayNames() {
        let sut = makeSUT(locale: Locale(identifier: "fr_FR"))
        let dateFormetter = DateFormatter()
        dateFormetter.locale = Locale(identifier: "fr_FR")
        
        XCTAssertEqual(sut.weekdayNames, dateFormetter.shortWeekdaySymbols)
    }
}

private extension WeekdayViewTests {
    func makeSUT(locale: Locale? = nil) -> WeekdayView {
        let sut = WeekdayView(appearance: .default, locale: locale ?? Locale.current)
        return sut
    }
}
