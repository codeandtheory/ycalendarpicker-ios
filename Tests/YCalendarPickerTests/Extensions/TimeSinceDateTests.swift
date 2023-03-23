//
//  TimeSinceDateTests.swift
//  YCalendarPicker
//
//  Created by Visakh Tharakan on 30/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import Foundation
import YCalendarPicker

final class TimeSinceDateTests: XCTestCase {
    func test_timeElapsed_deliversStringInSecondsAgo() {
        let sut = makeSUT(with: "2022-06-30 - 13:18:00")
        XCTAssertEqual(sut.timeElapsed(relativeTo: makeDate(with: "2022-06-30 - 13:18:53")), "53 seconds ago")
    }

    func test_timeElapsed_deliversStringInMinutesAgo() {
        let sut = makeSUT(with: "2022-06-30 - 13:18:00")
        XCTAssertEqual(sut.timeElapsed(relativeTo: makeDate(with: "2022-06-30 - 13:32:53")), "14 minutes ago")
    }

    func test_timeElapsed_deliversStringInHoursAgo() {
        let sut = makeSUT(with: "2022-06-30 - 13:18:00")
        XCTAssertEqual(sut.timeElapsed(relativeTo: makeDate(with: "2022-06-30 - 16:32:53")), "3 hours ago")
    }

    func test_timeElapsed_deliversStringInDaysAgo() {
        let sut = makeSUT(with: "2022-06-30 - 13:18:00")
        XCTAssertEqual(sut.timeElapsed(relativeTo: makeDate(with: "2022-07-02 - 16:32:53")), "2 days ago")
    }

    func test_timeElapsed_deliversStringInWeeksAgo() {
        let sut = makeSUT(with: "2022-06-30 - 13:18:00")
        XCTAssertEqual(sut.timeElapsed(relativeTo: makeDate(with: "2022-07-15 - 16:32:53")), "2 weeks ago")
    }

    func test_timeElapsed_deliversStringInMonthsAgo() {
        let sut = makeSUT(with: "2022-06-30 - 13:18:00")
        XCTAssertEqual(sut.timeElapsed(relativeTo: makeDate(with: "2022-08-07 - 16:32:53")), "1 month ago")
    }

    func test_timeElapsed_deliversStringInYearsAgo() {
        let sut = makeSUT(with: "2019-06-30 - 13:18:00")
        XCTAssertEqual(sut.timeElapsed(relativeTo: makeDate(with: "2022-08-07 - 16:32:53")), "3 years ago")
    }
}

private extension TimeSinceDateTests {
    func makeSUT(with dateString: String) -> Date {
        makeDate(with: dateString)
    }

    func makeDate(with dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd - HH:mm:ss"

        guard let date = dateFormatter.date(from: dateString) else {
            XCTFail("Expected to create date, but failed.")
            return Date()
        }
        return date
    }
}
