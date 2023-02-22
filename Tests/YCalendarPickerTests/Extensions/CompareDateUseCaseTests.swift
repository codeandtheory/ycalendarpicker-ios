//
//  CompareDateUseCaseTests.swift
//  YCalendarPicker
//
//  Created by Parv Bhaskar on 15/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class CompareDateUseCaseTests: XCTestCase {
    func test_isToday_returnFalseForYesterdayDate() {
        XCTAssertFalse(getYesterdayDate().isToday)
    }
    
    func test_isToday_returnFalseForAnyDateOtherThanToday() {
        XCTAssertFalse(getTomorrowDate().isToday)
        XCTAssertFalse(getNextMonthDate().isToday)
    }
    
    func test_isToday_returnTrueForTodaysDate() {
        XCTAssertTrue(Date().isToday)
    }
        
    func test_isTomorrow_returnFalseForToday() {
        XCTAssertFalse(Date().isTomorrow)
    }
    
    func test_isTomorrow_returnFalseForAnyDateOtherThanTomorrow() {
        XCTAssertFalse(getYesterdayDate().isTomorrow)
        XCTAssertFalse(getNextMonthDate().isTomorrow)
    }
    
    func test_isTomorrow_returnTrueForTomorrow() {
        XCTAssertTrue(getTomorrowDate().isTomorrow)
    }
    
    func test_isYesterday_returnFalseForToday() {
        XCTAssertFalse(Date().isYesterday)
    }
    
    func test_isYesterday_returnFalseForAnyDateOtherThanYesterday() {
        XCTAssertFalse(getTomorrowDate().isYesterday)
        XCTAssertFalse(getNextMonthDate().isYesterday)
    }
    
    func test_isYesterday_returnTrueForYesterday() {
        XCTAssertTrue(getYesterdayDate().isYesterday)
    }
    
    func test_isThisWeek_returnFalseForNextWeekDate() {
        XCTAssertFalse(getNextWeekDate().isThisWeek)
    }
    
    func test_isThisWeek_returnFalseForAnyDateOtherThanThisWeek() {
        XCTAssertFalse(getNextMonthDate().isThisWeek)
        XCTAssertFalse(getlastWeekDate().isThisWeek)
    }
    
    func test_isThisWeek_returnTrueForCurrentWeekDate() {
        XCTAssertTrue(Date().isThisWeek)
    }
        
    func test_isNextWeek_returnFalseForCurrentWeekDate() {
        XCTAssertFalse(Date().isNextWeek)
    }
    
    func test_isNextWeek_returnFalseForAnyDateOtherThanNextWeekDate() {
        XCTAssertFalse(getlastWeekDate().isNextWeek)
        XCTAssertFalse(getNextMonthDate().isNextWeek)
    }
    
    func test_isNextWeek_returnTrueForNextWeekDate() {
        XCTAssertTrue(getNextWeekDate().isNextWeek)
    }
    
    func test_isLastWeek_returnFalseForCurrentWeekDate() {
        XCTAssertFalse(Date().isLastWeek)
    }
    
    func test_isLastWeek_returnFalseForAnyDateOtherThanLastWeekDate() {
        XCTAssertFalse(getNextWeekDate().isLastWeek)
        XCTAssertFalse(getNextMonthDate().isLastWeek)
    }
    
    func test_isLastWeek_returnTrueForLastWeekDate() {
        XCTAssertTrue(getlastWeekDate().isLastWeek)
    }
    
    func test_isThisYear_returnFalseForNextYearDate() {
        XCTAssertFalse(getNextYearDate().isThisYear)
    }
    
    func test_isThisYear_returnFalseForAnyDateOtherThanThisYearDate() {
        XCTAssertFalse(getLastYearDate().isThisYear)
    }
    
    func test_isThisYear_returnTrueForCurrentYearDate() {
        XCTAssertTrue(Date().isThisYear)
    }
    
    func test_isNextYear_returnFalseForCurrentYear() {
        XCTAssertFalse(Date().isNextYear)
    }
    
    func test_isNextYear_returnFalseForAnyDateOtherThanNextYear() {
        XCTAssertFalse(getLastYearDate().isNextYear)
    }
    
    func test_isNextYear_returnTrueForNextYear() {
        XCTAssertTrue(getNextYearDate().isNextYear)
    }
    
    func test_isLastYear_returnFalseForCurrentYear() {
        XCTAssertFalse(Date().isLastYear)
    }
    
    func test_isLastYear_returnFalseForAnyDateOtherThanLastYear() {
        XCTAssertFalse(getNextYearDate().isLastYear)
    }
    
    func test_isLastYear_returnTrueForLastYear() {
        XCTAssertTrue(getLastYearDate().isLastYear)
    }
    
    func test_isThisMonth_returnFalseForNextMonth() {
        XCTAssertFalse(getNextMonthDate().isThisMonth)
    }
    
    func test_isThisMonth_returnFalseForAnyDateOtherThanNextMonth() {
        XCTAssertFalse(getLastYearDate().isThisMonth)
        XCTAssertFalse(getNextYearDate().isThisMonth)
    }
    
    func test_isThisMonth_returnTrueForCurrentMonth() {
        XCTAssertTrue(Date().isThisMonth)
    }
    
    func test_isLastMonth_returnFalseForNextMonth() {
        XCTAssertFalse(getNextMonthDate().isLastMonth)
    }
    
    func test_isLastMonth_returnFalseForAnyDateOtherThanLastMonth() {
        XCTAssertFalse(getLastYearDate().isLastMonth)
        XCTAssertFalse(getNextYearDate().isLastMonth)
    }
    
    func test_isLastMonth_returnTrueForLastMonth() {
        XCTAssertTrue(getLastMonthDate().isLastMonth)
    }

    func test_isNextMonth_returnFalseForCurrentMonth() {
        XCTAssertFalse(Date().isNextMonth)
    }
    
    func test_isNextMonth_returnFalseForAnyDateOtherThanNextMonth() {
        XCTAssertFalse(getLastYearDate().isNextMonth)
        XCTAssertFalse(getNextYearDate().isNextMonth)
    }
    
    func test_isNextMonth_returnTrueForNextMonth() {
        XCTAssertTrue(getNextMonthDate().isNextMonth)
    }
    
    func test_isSameDay_returnFalseForDifferentDate() {
        XCTAssertFalse(Date().isSameDay(as: getYesterdayDate()))
        XCTAssertFalse(getTomorrowDate().isSameDay(as: getYesterdayDate()))
    }
    
    func test_isSameDay_returnTrueForSameDate() {
        XCTAssertTrue(Date().isSameDay(as: Date()))
        XCTAssertTrue(getYesterdayDate().isSameDay(as: getYesterdayDate()))
    }

    func test_isSameWeek_returnFalseForDifferentWeeks() {
        XCTAssertFalse(Date().isSameWeek(as: getlastWeekDate()))
        XCTAssertFalse(getNextWeekDate().isSameWeek(as: getlastWeekDate()))
    }
    
    func test_isSameWeek_returnTrueForSameWeeks() {
        XCTAssertTrue(Date().isSameWeek(as: Date()))
        XCTAssertTrue(getlastWeekDate().isSameWeek(as: getlastWeekDate()))
        XCTAssertTrue(getNextWeekDate().isSameWeek(as: getNextWeekDate()))
    }

    func test_isSameMonth_returnFalseForDifferentMonths() {
        XCTAssertFalse(Date().isSameMonth(as: getNextMonthDate()))
    }
    
    func test_isSameMonth_returnTrueForSameMonths() {
        XCTAssertTrue(Date().isSameMonth(as: Date()))
        XCTAssertTrue(getNextMonthDate().isSameMonth(as: getNextMonthDate()))
    }
    
    func test_isSameYear_returnFalseForDifferentYear() {
        XCTAssertFalse(Date().isSameYear(as: getNextYearDate()))
        XCTAssertFalse(getLastYearDate().isSameYear(as: getNextYearDate()))
    }
    
    func test_isSameYear_returnTrueForSameYear() {
        XCTAssertTrue(Date().isSameYear(as: Date()))
        XCTAssertTrue(getLastYearDate().isSameYear(as: getLastYearDate()))
        XCTAssertTrue(getNextYearDate().isSameYear(as: getNextYearDate()))
    }
}

private extension CompareDateUseCaseTests {
    // MARK: - Helpers
    func getYesterdayDate() -> Date! {
        Calendar.current.date(byAdding: .day, value: -1, to: Date())
    }
    
    func getTomorrowDate() -> Date! {
        Calendar.current.date(byAdding: .day, value: 1, to: Date())
    }
    
    func getNextWeekDate() -> Date! {
        Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())
    }
    
    func getlastWeekDate() -> Date! {
        Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date())
    }
    
    func getNextYearDate() -> Date! {
        Calendar.current.date(byAdding: .year, value: 1, to: Date())
    }
    
    func getLastYearDate() -> Date! {
        Calendar.current.date(byAdding: .year, value: -1, to: Date())
    }
    
    func getNextMonthDate() -> Date! {
        Calendar.current.date(byAdding: .month, value: 1, to: Date())
    }
    
    func getLastMonthDate() -> Date! {
        Calendar.current.date(byAdding: .month, value: -1, to: Date())
    }
}
