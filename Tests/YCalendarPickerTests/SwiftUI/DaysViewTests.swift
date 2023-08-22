//
//  DaysViewTests.swift
//  YCalendarPicker
//
//  Created by Sahil on 15/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import SwiftUI
@testable import YCalendarPicker

final class DaysViewTests: XCTestCase {
    func testDayIsNotNil() throws {
        let sut = makeSUT()
        let startDate = Date().startDateOfMonth()
        let previousMonthDateCount = try XCTUnwrap(Calendar.current.dateComponents([.weekday], from: startDate).weekday)
        let dayCount = try XCTUnwrap(Int(Date().get(.day)))
        let index = previousMonthDateCount + dayCount
        let day = sut.getDay(index: index)
        XCTAssertNotNil(day)
    }
    
    func testDateBodyisNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.body)
    }
    
    func testDateBodyPreviewisNotNil() {
        let sutPreview = DaysView_Previews.previews
        XCTAssertNotNil(sutPreview)
    }
}

private extension DaysViewTests {
    func makeSUT() -> DaysView {
        let allDates: [CalendarMonthItem] = Date().getAllDatesForSelectedMonth(firstWeekIndex: 0)
        let sut = DaysView(
            allDates: allDates,
            appearance: .default,
            selectedDate: .constant(Date()),
            locale: Locale.current,
            currentDate: Date()
        )
        XCTAssertNotNil(sut.body)
        return sut
    }
}
