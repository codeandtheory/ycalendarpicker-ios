//
//  YCalendarPickerTests.swift
//  YCalendarPicker
//
//  Created by YML on 16/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class YCalendarPickerTests: XCTestCase {
    func testYCalendarPickerIsNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func testCalendarViewIsNotNil() {
        let sut = makeSUT()
        sut.appearance = .default
        XCTAssertNotNil(sut.calendarView)
    }

    func testCalendarViewAppearanceSetCorrectly() {
        let sut = makeSUT()
        sut.appearance = YCalendarPicker.Appearance(weekdayStyle: (textColor: .red, typography: .weekday))
        XCTAssertEqual(UIColor.red, sut.appearance.weekdayStyle.textColor)
    }
    
    func testCalendarViewMinDateSetCorrectly() {
        let sut = makeSUT()
        let minDate = Date().previousDate()
        sut.minimumDate = minDate
        XCTAssertEqual(sut.minimumDate, minDate.dateOnly)
    }
    
    func testCalendarViewMaxDateSetCorrectly() {
        let sut = makeSUT()
        let maxDate = Date().previousDate()
        sut.maximumDate = maxDate
        XCTAssertEqual(sut.maximumDate, maxDate.dateOnly)
    }
    
    func testCalendarPickerMaxMinDateSetCorrectly() {
        let maxDate = Date()
        let minDate = Date().previousDate()
        let sut = makeSUT(maxDate: maxDate, minDate: minDate)
        XCTAssertEqual(sut.calendarView.minimumDate, minDate.dateOnly)
        XCTAssertEqual(sut.calendarView.maximumDate, maxDate.dateOnly)
    }
    
    func testCalendarPickerBookedDatesSetCorrectly() {
        let bookedDates = [Date().dateOnly, Date().previousDate().dateOnly]
        let sut = makeSUT()
        sut.bookedDates = bookedDates
        XCTAssertEqual(sut.bookedDates, bookedDates)
        XCTAssertEqual(sut.calendarView.bookedDates, bookedDates)
    }
    
    func testSelectedDate() throws {
        let sut = makeSUT()
        XCTAssertNil(sut.date)
        let selectedDate = try XCTUnwrap(Date().date(byAddingMonth: 1))
        sut.date = selectedDate
        XCTAssertEqual(sut.date, selectedDate.dateOnly)
    }
    
    func testCalendarPickerIsNotNilForOptionalInit() {
        XCTAssertNotNil(makeSUTWithFailable())
    }

    func testCalendarPickerUpdatesDate() throws {
        let sut = makeSUT()
        XCTAssertNil(sut.date)

        let newDate = try XCTUnwrap(Date().date(byAddingMonth: 1))

        sut.calendarView.selectedDateDidChange(newDate)
        XCTAssertEqual(sut.date, newDate.dateOnly)

        sut.calendarView.selectedDateDidChange(nil)
        XCTAssertNil(sut.date)
    }

    func testCalendarPickerUpdatesDateOnlyFromOwnCalendarView() throws {
        let sut = makeSUT()
        let sut2 = makeSUT()
        XCTAssertNil(sut.date)
        XCTAssertNil(sut2.date)

        let date1 = try XCTUnwrap(Date().date(byAddingMonth: 1)?.dateOnly)
        let date2 = try XCTUnwrap(Date().date(byAddingMonth: -1)?.dateOnly)

        sut2.calendarView.selectedDateDidChange(date2)
        XCTAssertNil(sut.date)
        XCTAssertEqual(sut2.date, date2)

        sut.calendarView.selectedDateDidChange(date1)
        XCTAssertEqual(sut.date, date1)
        XCTAssertEqual(sut2.date, date2)
        
        sut.calendarView.monthDidChange(date2)
        XCTAssertNotEqual(sut.calendarView.currentDate, date2)
        
        sut2.calendarView.monthDidChange(date1)
        XCTAssertNotEqual(sut.calendarView.currentDate, date2)
    }
}

private extension YCalendarPickerTests {
    func makeSUT(
        firstWeekday: Int? = nil,
        maxDate: Date? = nil,
        minDate: Date? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> YCalendarPicker {
        let sut = YCalendarPicker(minimumDate: minDate, maximumDate: maxDate)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    func makeSUTWithFailable(
        firstWeekday: Int? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> YCalendarPicker? {
        let sut = YCalendarPicker()
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: sut, requiringSecureCoding: false) else {
            return nil
        }
        guard let coder = try? NSKeyedUnarchiver(forReadingFrom: data) else { return nil }
        trackForMemoryLeaks(sut, file: file, line: line)
        return YCalendarPicker(coder: coder)
    }
}
