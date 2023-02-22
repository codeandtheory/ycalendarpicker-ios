//
//  CalendarHeaderViewTests.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 29/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import SwiftUI
@testable import YCalendarPicker

final class CalendarHeaderViewTests: XCTestCase {
    func testMonthAndYearisNotEmpty() {
        let sut = makeSUT(headerDateFormat: "")
        let monthAndYear = sut.getMonthAndYear()
        XCTAssertNotEqual(monthAndYear, "")
    }
    
    func testHeaderMonthAndYear() {
        let sut = makeSUT()
        let monthAndYear = sut.getMonthAndYear()
        XCTAssertEqual(monthAndYear, Date().toString(withTemplate: "MMMMyyyy"))
    }
    
    func testCurrentDateUpdateCorrectly() {
        let sut = makeSUT()
        let nextExpectedDate = Date().date(byAddingMonth: 1)?.dateOnly
        let prevExpectedDate2 = Date().date(byAddingMonth: -1)?.dateOnly
        sut.updateCurrentDate(byAddingMonth: 1)
        
        XCTAssertEqual(sut.currentDate, nextExpectedDate)
        sut.updateCurrentDate(byAddingMonth: -2) // -2 as we have already updated with +1
        XCTAssertEqual(sut.currentDate, prevExpectedDate2)
    }
    
    func testHeaderNextImageIsCorrect() {
        var sut = makeSUT()
        sut.appearance = YCalendarPicker.Appearance(nextImage: nil)
        let nextImage = sut.getNextImage()
        XCTAssertEqual(nextImage, Image(systemName: "chevron.right").renderingMode(.template))
    }
    
    func testHeaderPreviousImageIsCorrect() {
        var sut = makeSUT()
        sut.appearance = YCalendarPicker.Appearance(previousImage: nil)
        let previousImage = sut.getPreviousImage()
        XCTAssertEqual(previousImage, Image(systemName: "chevron.left").renderingMode(.template))
    }
    
    func testIsDisableForNextButtonWorkingCorrectly() {
        let sut = makeSUT(
            minimumDate: Date().date(byAddingMonth: -1),
            maximumDate: Date().date(byAddingMonth: 1)
        )

        XCTAssertFalse(sut.isNextButtonDisabled)
        
        sut.updateCurrentDate(byAddingMonth: 2)
        XCTAssertTrue(sut.isNextButtonDisabled)
    }
    
    func testIsDisableForPreviousButtonWorkingCorrectly() {
        let sut = makeSUT(
            minimumDate: Date().date(byAddingMonth: -1),
            maximumDate: Date().date(byAddingMonth: 1)
        )

        XCTAssertFalse(sut.isPreviousButtonDisabled)
        
        sut.updateCurrentDate(byAddingMonth: -2)
        XCTAssertTrue(sut.isPreviousButtonDisabled)
    }
    
    func testMonthAndYearTextWithDifferentLocale() {
        let sut = makeSUT(locale: Locale(identifier: "de_DE"))
        let monthAndYearText = sut.getMonthAndYear()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "de_DE")
        
        XCTAssertEqual(monthAndYearText, dateFormatter.string(from: Date()))
    }
    
    func testMonthAndYearTextWithDefaultLocale() {
        let sut = makeSUT()
        let monthAndYearText = sut.getMonthAndYear()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale.current
        
        XCTAssertEqual(monthAndYearText, dateFormatter.string(from: Date()))
    }
    
    func testHeaderPreviewIsNotNill() {
        XCTAssertNotNil(CalendarHeaderView_Previews.previews)
    }
}

private extension CalendarHeaderViewTests {
    func makeSUT(
        firstWeekday: Int? = nil,
        headerDateFormat: String? = nil,
        minimumDate: Date? = nil,
        maximumDate: Date? = nil,
        locale: Locale? = nil
    ) -> CalendarHeaderView {
        var newDate = Date()
        let currentDate = Binding(
            get: { newDate },
            set: { newDate = $0 }
        )
        let sut = CalendarHeaderView(
            currentDate: currentDate,
            appearance: .default,
            headerDateFormat: "MMMMyyyy",
            minimumDate: minimumDate?.dateOnly,
            maximumDate: maximumDate?.dateOnly,
            locale: locale ?? Locale.current
        )
        XCTAssertNotNil(sut.body)
        return sut
    }
}
