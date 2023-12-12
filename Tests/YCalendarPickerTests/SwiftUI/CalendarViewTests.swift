//
//  CalendarViewTests.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 16/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker
import SwiftUI

final class CalendarViewTests: XCTestCase {
    func testDaysViewisNotNil() {
        let sut = makeSUT()
        let daysView = sut.getDaysView()
        XCTAssertNotNil(daysView)
    }
    
    func testMonthViewisNotNil() {
        let sut = makeSUT()
        let monthView = sut.getMonthView()
        XCTAssertNotNil(monthView)
    }
    
    func testDateBodyisNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.body)
    }

    func testReuseIdentifierIsNotEmpty() {
        let sut = makeSUT()
        XCTAssertFalse(sut.reuseIdentifier.uuidString.isEmpty)
    }

    func testShouldEnableDateForNilMaxAndMinDate() {
        let sut = makeSUT()
        XCTAssertEqual(sut.shouldEnableDate(Date(), minimumDate: nil, maximumDate: nil), true)
    }
    
    func testUpdatedCurrentDateOnLeftSwipe() {
        let sut = makeSUT()
        let expectedDate = Date().startDateOfMonth().date(byAddingMonth: 1)?.dateOnly
        let updatedDate = sut.getCurrentDateAfterSwipe(swipeValue: CGSize(width: -10, height: 10))
        XCTAssertEqual(expectedDate, updatedDate)
    }
    
    func testUpdatedCurrentDateOnRightSwipe() {
        let sut = makeSUT()
        let expectedDate = Date().startDateOfMonth().date(byAddingMonth: -1)?.dateOnly
        let updatedDate = sut.getCurrentDateAfterSwipe(swipeValue: CGSize(width: 10, height: 10))
        XCTAssertEqual(expectedDate, updatedDate)
    }
    
    func testShouldEnableDateForDateLessThanMinimumDate() {
        let sut = makeSUT()
        let minimumDate = Date().nextDate()
        let maximumDate = Date().date(byAddingMonth: 1)
        let dateToTest = Date()
        let isEnable = sut.shouldEnableDate(dateToTest, minimumDate: minimumDate, maximumDate: maximumDate)
        XCTAssertFalse(isEnable)
    }
    
    func testShouldEnableDateForDateInRange() {
        let sut = makeSUT()
        let minimumDate = Date().previousDate()
        let maximumDate = Date().date(byAddingMonth: 1)
        let dateToTest = Date()
        let isEnable = sut.shouldEnableDate(dateToTest, minimumDate: minimumDate, maximumDate: maximumDate)
        XCTAssertTrue(isEnable)
    }
    
    func testShouldEnableDateForMaxDateOutOfRange() {
        let sut = makeSUT()
        let minimumDate = Date().date(byAddingMonth: -2)
        let maximumDate = Date().date(byAddingMonth: -1)
        let dateToTest = Date()
        let isEnable = sut.shouldEnableDate(dateToTest, minimumDate: minimumDate, maximumDate: maximumDate)
        XCTAssertFalse(isEnable)
    }
    
    func testSettingMinDate() {
        var minimumDate = Date().date(byAddingMonth: -1)
        // Initialize date with any value
        var sut = makeSUT(minimumDate: minimumDate)
        // test with initialized values
        XCTAssertEqual(sut.minimumDate, minimumDate?.dateOnly)
        // update with new value
        minimumDate = minimumDate?.date(byAddingMonth: -1)
        sut.minimumDate = minimumDate
        // test with updated value
        XCTAssertEqual(sut.minimumDate, minimumDate?.dateOnly)
    }
    
    func testSettingMinDateUpdateInitWithNilValue() {
        // Initialize date with any value
        var sut = makeSUT()
        // test with initialized values
        XCTAssertEqual(sut.minimumDate, nil)
        // update with new value
        let minimumDate = Date().date(byAddingMonth: -1)
        sut.minimumDate = minimumDate
        // test with updated value
        XCTAssertEqual(sut.minimumDate, minimumDate?.dateOnly)
    }
    
    func testMinDateWithSelectedDateLessThanMinDate() throws {
        let sut = makeSUT(minimumDate: Date())
        let selectedDate = try XCTUnwrap(Date().date(byAddingMonth: -1))
        XCTAssertTrue(sut.isDateBeforeMinimumDate(selectedDate))
    }
    
    func testMinDateWithSelectedDateGreaterThanMinDate() throws {
        let sut = makeSUT(minimumDate: Date())
        let selectedDate = try XCTUnwrap(Date().date(byAddingMonth: 1))
        XCTAssertFalse(sut.isDateBeforeMinimumDate(selectedDate))
    }
    
    func testMaxDateWithSelectedDateLessThanMaxDate() throws {
        let sut = makeSUT(maximumDate: Date())
        let selectedDate = try XCTUnwrap(Date().date(byAddingMonth: -1))
        XCTAssertFalse(sut.isDateAfterMaximumDate(selectedDate))
    }
    
    func testMaxDateWithSelectedDateGreaterThanMaxDate() throws {
        let sut = makeSUT(maximumDate: Date())
        let selectedDate = try XCTUnwrap(Date().date(byAddingMonth: 1))
        XCTAssertTrue(sut.isDateAfterMaximumDate(selectedDate))
    }
    
    func testBookedDateWithSelectedDate() throws {
        var sut = makeSUT()
        let selectedDate = try XCTUnwrap(Date().date(byAddingMonth: 1)?.dateOnly)
        sut.bookedDates = [selectedDate]
        XCTAssertTrue(sut.isBooked(selectedDate))
    }
    
    func testSelectedDate() throws {
        var sut = makeSUT()
        XCTAssertNil(sut.date)
        let selectedDate = try XCTUnwrap(Date().date(byAddingMonth: 1)?.dateOnly)
        sut.date = selectedDate
        XCTAssertEqual(sut.date, selectedDate)
    }
    
    func testDateBodyPreviewisNotNil() {
        XCTAssertNotNil(CalendarView_Previews.previews)
    }
    
    func testStartOfTheWeekdayIndex() {
        let startWeekIndex = 1
        let sut = makeSUT(firstWeekday: startWeekIndex)
        XCTAssertEqual(startWeekIndex, sut.firstWeekday)
    }
    
    func testOnMaximumDateChangeForSelectedDateIsNil() {
        var sut = makeSUT(minimumDate: Date().previousDate())
        sut.date = Date().date(byAddingDays: 3)
        XCTAssertNotNil(sut.date)
        sut.maximumDate = Date()
        XCTAssertNil(sut.date)
    }
    
    func testOnBookedDateChangeForSelectedDateIsNil() {
        var sut = makeSUT()
        sut.date = Date().date(byAddingDays: 3)
        XCTAssertNotNil(sut.date)
        sut.bookedDates = [Date().date(byAddingDays: 3) ?? Date()]
        XCTAssertNil(sut.date)
    }
    
    func testOnMinimumDateChangeForSelectedDateIsNil() {
        var sut = makeSUT()
        sut.date = Date().date(byAddingDays: -3)
        XCTAssertNotNil(sut.date)
        sut.minimumDate = Date()
        XCTAssertNil(sut.date)
    }
    
    func testOnStartDate() {
        let expectedDate = Date().date(byAddingMonth: 4)
        let sut = makeSUT(startDate: expectedDate)
        XCTAssertNotNil(sut.startDate)
        XCTAssertEqual(expectedDate?.startDateOfMonth(), sut.startDate)
    }
    
    func testCalendarViewPreviewIsNotNill() {
        XCTAssertNotNil(CalendarView_Previews.previews)
    }

    func testReuseIdentifierIsUnique() {
        XCTAssertNotEqual(makeSUT().reuseIdentifier, makeSUT().reuseIdentifier)
    }
}

private extension CalendarViewTests {
    func makeSUT(
        firstWeekday: Int? = nil,
        minimumDate: Date? = nil,
        maximumDate: Date? = nil,
        startDate: Date? = nil
    ) -> CalendarView {
        let sut = CalendarView(
            firstWeekday: firstWeekday ?? 0,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            startDate: startDate
        )
        XCTAssertNotNil(sut.body)
        return sut
    }
}
