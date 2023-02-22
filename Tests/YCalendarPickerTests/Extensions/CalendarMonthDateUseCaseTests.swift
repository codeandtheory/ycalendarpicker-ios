//
//  CalendarMonthDateUseCaseTests.swift
//  YCalendarPicker
//
//  Created by Parv Bhaskar on 17/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import XCTest
@testable import YCalendarPicker

final class CalendarMonthDateUseCaseTests: XCTestCase {
    func test_getPreviousMonthDates_deliversPreviousMonthDates() {
        let date1 = makeCalendarMonthItem(date: makeDate(for: "2022-05-29"))
        let date2 = makeCalendarMonthItem(date: makeDate(for: "2022-05-30"))
        let date3 = makeCalendarMonthItem(date: makeDate(for: "2022-05-31"))

        XCTAssertEqual(makeSUT(with: "2022-06-17").getPreviousMonthDates(firstWeekIndex: 0), [date1, date2, date3])
    }
    
    func test_getNextMonthDates_deliversNextMonthDates() {
        let date1 = makeCalendarMonthItem(date: makeDate(for: "2022-05-01"))
        let date2 = makeCalendarMonthItem(date: makeDate(for: "2022-05-02"))
        let date3 = makeCalendarMonthItem(date: makeDate(for: "2022-05-03"))
        let date4 = makeCalendarMonthItem(date: makeDate(for: "2022-05-04"))
        let date5 = makeCalendarMonthItem(date: makeDate(for: "2022-05-05"))
        let date6 = makeCalendarMonthItem(date: makeDate(for: "2022-05-06"))
        let date7 = makeCalendarMonthItem(date: makeDate(for: "2022-05-07"))

        XCTAssertEqual(
            makeSUT(with: "2022-04-17").getNextMonthDates(firstWeekIndex: 0),
            [date1, date2, date3, date4, date5, date6, date7]
        )
    }
    
    func test_getSelectedMonthDates() {
        XCTAssertEqual(makeSUT(with: "2022-06-17").getSelectedMonthDates().count, 30)
        XCTAssertEqual(makeSUT(with: "2022-07-17").getSelectedMonthDates().count, 31)
        XCTAssertEqual(makeSUT(with: "2023-01-01").getSelectedMonthDates().count, 31)
    }
    
    func test_getAllDatesForSelectedMonth() {
        let allDates = makeSUT(with: "2022-06-17").getAllDatesForSelectedMonth(firstWeekIndex: 0)
        XCTAssertEqual(allDates.count, 42)
        XCTAssertEqual(
            allDates.first,
            makeCalendarMonthItem(date: makeDate(for: "2022-05-29"))
        )
        XCTAssertEqual(
            allDates.last,
            makeCalendarMonthItem(date: makeDate(for: "2022-07-09"))
        )
    }
    
    func test_getAllDatesForSelectedMonth_weekStartsOnMonday() {
        let askedDate = makeSUT(with: "2022-07-17").getAllDatesForSelectedMonth(firstWeekIndex: 1)[0]
        XCTAssertEqual(askedDate.date.indexOfWeekday(), Weekday.monday.rawValue)
    }
        
    func test_get_dateConvertedToStringShouldBeExact() {
        let sut = makeSUT(with: "2022-06-17")
        
        XCTAssertEqual(sut.get(.day), "17")
        XCTAssertEqual(sut.get(.month), "6")
        XCTAssertEqual(sut.get(.year), "2022")
    }
    
    func test_indexOfWeekday() {
        XCTAssertEqual(makeSUT(with: "2022-06-08").indexOfWeekday(), Weekday.wednesday.rawValue)
        XCTAssertEqual(makeSUT(with: "2022-06-24").indexOfWeekday(), Weekday.friday.rawValue)
    }
    
    func test_toCalendarItem() {
        let sut = makeSUT(with: "2022-06-08")
        let item = sut.toCalendarItem()
        
        XCTAssertEqual(item.day, "8")
        XCTAssertEqual(item.month, "6")
        XCTAssertEqual(item.year, "2022")
        XCTAssertFalse(item.isToday)
        XCTAssertFalse(item.isGrayedOut)

        XCTAssertTrue(sut.toCalendarItem(isGrayedOut: true).isGrayedOut)
    }

    func test_startDateOfMonth_deliversStartDate() {
        let startDate = makeDate(for: "2022-06-01")

        XCTAssertEqual(makeSUT(with: "2022-06-01").startDateOfMonth(), startDate)
        XCTAssertEqual(makeSUT(with: "2022-06-15").startDateOfMonth(), startDate)
        XCTAssertEqual(makeSUT(with: "2022-06-30").startDateOfMonth(), startDate)
    }

    func test_endDateOfMonth_deliversEndDate() {
        let endDate = makeDate(for: "2022-06-30")

        XCTAssertEqual(makeSUT(with: "2022-06-01").endDateOfMonth(), endDate)
        XCTAssertEqual(makeSUT(with: "2022-06-15").endDateOfMonth(), endDate)
        XCTAssertEqual(makeSUT(with: "2022-06-30").endDateOfMonth(), endDate)
    }

    func test_previousDate_deliversPreviousDate() {
        XCTAssertEqual(makeSUT(with: "2022-06-01").previousDate(), makeDate(for: "2022-05-31"))
        XCTAssertEqual(makeSUT(with: "2022-06-15").previousDate(), makeDate(for: "2022-06-14"))
        XCTAssertEqual(makeSUT(with: "2022-06-30").previousDate(), makeDate(for: "2022-06-29"))
    }

    func test_nextDate_deliversNextDate() {
        XCTAssertEqual(makeSUT(with: "2022-06-01").nextDate(), makeDate(for: "2022-06-02"))
        XCTAssertEqual(makeSUT(with: "2022-06-15").nextDate(), makeDate(for: "2022-06-16"))
        XCTAssertEqual(makeSUT(with: "2022-06-30").nextDate(), makeDate(for: "2022-07-1"))
    }

    func test_dateByAddingDays_deliversNewDateWithAddedDays() {
        let sut1 = makeSUT(with: "2022-06-01")
        XCTAssertEqual(sut1.date(byAddingDays: 0), sut1)
        XCTAssertEqual(makeSUT(with: "2022-06-01").date(byAddingDays: 1), makeDate(for: "2022-06-02"))
        XCTAssertEqual(makeSUT(with: "2022-06-01").date(byAddingDays: 2), makeDate(for: "2022-06-03"))
        XCTAssertEqual(makeSUT(with: "2022-06-01").date(byAddingDays: -1), makeDate(for: "2022-05-31"))

        let sut2 = makeSUT(with: "2022-06-15")
        XCTAssertEqual(sut2.date(byAddingDays: 0), sut2)
        XCTAssertEqual(makeSUT(with: "2022-06-15").date(byAddingDays: 1), makeDate(for: "2022-06-16"))
        XCTAssertEqual(makeSUT(with: "2022-06-15").date(byAddingDays: 2), makeDate(for: "2022-06-17"))

        let sut3 = makeSUT(with: "2022-06-30")
        XCTAssertEqual(sut3.date(byAddingDays: 0), sut3)
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingDays: 1), makeDate(for: "2022-07-01"))
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingDays: 2), makeDate(for: "2022-07-02"))
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingDays: -1), makeDate(for: "2022-06-29"))
    }

    func test_dateByAddingMonth_deliversNewDateWithAddedMonth() {
        let sut1 = makeSUT(with: "2022-06-01")
        XCTAssertEqual(sut1.date(byAddingMonth: 0), sut1)
        XCTAssertEqual(makeSUT(with: "2022-06-01").date(byAddingMonth: 1), makeDate(for: "2022-07-01"))
        XCTAssertEqual(makeSUT(with: "2022-06-01").date(byAddingMonth: 2), makeDate(for: "2022-08-01"))

        let sut2 = makeSUT(with: "2022-06-15")
        XCTAssertEqual(sut2.date(byAddingMonth: 0), sut2)
        XCTAssertEqual(makeSUT(with: "2022-06-15").date(byAddingMonth: 1), makeDate(for: "2022-07-15"))
        XCTAssertEqual(makeSUT(with: "2022-06-15").date(byAddingMonth: 2), makeDate(for: "2022-08-15"))

        let sut3 = makeSUT(with: "2022-06-30")
        XCTAssertEqual(sut3.date(byAddingMonth: 0), sut3)
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingMonth: 1), makeDate(for: "2022-07-30"))
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingMonth: 2), makeDate(for: "2022-08-30"))
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingMonth: -1), makeDate(for: "2022-05-30"))
    }

    func test_dateByAddingYear_deliversNewDateWithAddedYear() {
        let sut1 = makeSUT(with: "2022-06-1")
        XCTAssertEqual(sut1.date(byAddingYear: 0), sut1)
        XCTAssertEqual(makeSUT(with: "2022-06-01").date(byAddingYear: 1), makeDate(for: "2023-06-01"))
        XCTAssertEqual(makeSUT(with: "2022-06-01").date(byAddingYear: 2), makeDate(for: "2024-06-01"))

        let sut2 = makeSUT(with: "2022-06-15")
        XCTAssertEqual(sut2.date(byAddingYear: 0), sut2)
        XCTAssertEqual(makeSUT(with: "2022-06-15").date(byAddingYear: 1), makeDate(for: "2023-06-15"))
        XCTAssertEqual(makeSUT(with: "2022-06-15").date(byAddingYear: 2), makeDate(for: "2024-06-15"))

        let sut3 = makeSUT(with: "2022-06-30")
        XCTAssertEqual(sut3.date(byAddingYear: 0), sut3)
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingYear: 1), makeDate(for: "2023-06-30"))
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingYear: 2), makeDate(for: "2024-06-30"))
        XCTAssertEqual(makeSUT(with: "2022-06-30").date(byAddingYear: -1), makeDate(for: "2021-06-30"))
    }

    func test_numberOfDaysInMonth_deliversNumberOfDaysInMonth() {
        XCTAssertEqual(makeSUT(with: "2022-02-15").numberOfDaysInMonth(), 28)
        XCTAssertEqual(makeSUT(with: "2022-06-15").numberOfDaysInMonth(), 30)
        XCTAssertEqual(makeSUT(with: "2022-07-15").numberOfDaysInMonth(), 31)
    }
}

private extension CalendarMonthDateUseCaseTests {
    // MARK: - Helpers

    enum Weekday: Int {
        case monday = 2
        case wednesday = 4
        case friday = 6
    }
    
    func makeSUT(with dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            XCTFail("Expected to create SUT, but failed.")
            return Date()
        }
        
        return date
    }
    
    func makeDate(for dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            XCTFail("Expected to create date, but failed.")
            return Date()
        }
        
        return date
    }
    
    func makeCalendarMonthItem(
        date: Date
    ) -> CalendarMonthItem {
        date.toCalendarItem(isGrayedOut: true)
    }
}
