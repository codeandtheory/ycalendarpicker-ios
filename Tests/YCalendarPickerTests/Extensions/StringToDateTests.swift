//
//  StringToDateTests.swift
//  YCalendarPicker
//
//  Created by Sanjib Chakraborty on 20/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCalendarPicker

final class StringToDateTests: XCTestCase {
    func test_toDateWithFormatType() {
        var sut: Date?
        var compareDate: Date?
        let calendar = Calendar.current
        let timeZone = TimeZone(abbreviation: "IST")

        // format string - "MM/dd/yyyy"
        compareDate = calendar.date(from: DateComponents(year: 2022, month: 06, day: 05))
        sut = "06/05/2022".toDate(withFormatType: DateFormatType.MMddyyyy(separator: "/"))
        XCTAssertEqual(sut, compareDate)

        // format string - "dd-MM-yyyy"
        compareDate = calendar.date(from: DateComponents(year: 2022, month: 06, day: 05))
        sut = "05-06-2022".toDate(withFormatType: DateFormatType.ddMMyyyy(separator: "-"))
        XCTAssertEqual(sut, compareDate)

        // format string - "yyyy"
        compareDate = calendar.date(from: DateComponents(year: 2022))
        sut = "2022".toDate(withFormatType: DateFormatType.yyyy)
        XCTAssertEqual(sut, compareDate)

        // format string - "EEE, d MMM yyyy HH:mm:ss ZZZ". HTTP header date format
        compareDate = calendar.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        sut = "Sun, 5 Jun 2022 10:42:52 +0530".toDate(withFormatType: DateFormatType.httpHeader)
        XCTAssertEqual(sut, compareDate)
    }

    func test_toDateWithFormatTypeCustom() {
        var sut: Date?
        var compareDate: Date?
        let calendar = Calendar.current
        let timeZone = TimeZone(abbreviation: "IST")

        // format string - "yyyy-MM-dd'T'HH:mmZ"
        compareDate = calendar.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42)
        )
        sut = "2022-06-05T10:42+0530".toDate(withFormatType: DateFormatType.custom(format: "yyyy-MM-dd'T'HH:mmZ"))
        XCTAssertEqual(sut, compareDate)

        // format string - "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        compareDate = calendar.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        sut = "2022-06-05T10:42:52.000+0530".toDate(
            withFormatType: DateFormatType.custom(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        )
        XCTAssertEqual(sut, compareDate)

        // format string - "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        compareDate = calendar.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        sut = "2022-06-05T10:42:52+05:30".toDate(
            withFormatType: DateFormatType.custom(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
        )
        XCTAssertEqual(sut, compareDate)

        // format string - "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        compareDate = calendar.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        sut = "2022-06-05T10:42:52+05:30".toDate(
            withFormatType: DateFormatType.custom(format: "yyyy_MM_dd'T'HH:mm:ssZZZZZ", separator: "-")
        )
        XCTAssertEqual(sut, compareDate)

        // format string - "dd MMM yyyy, h:mm a"
        compareDate = calendar.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42)
        )
        sut = "05 Jun 2022, 10:42 AM".toDate(
            withFormatType: DateFormatType.custom(format: "dd MMM yyyy, h:mm a"),
            timeZone: timeZone
        )
        XCTAssertEqual(sut, compareDate)

        // format string - "dd MMM yyyy, h:mm a" in PST timezone
        compareDate = calendar.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42)
        )
        sut = "04 Jun 2022, 10:12 PM".toDate(
            withFormatType: DateFormatType.custom(format: "dd MMM yyyy, h:mm a"),
            timeZone: TimeZone(abbreviation: "PST")
        )
        XCTAssertEqual(sut, compareDate)
    }
}
