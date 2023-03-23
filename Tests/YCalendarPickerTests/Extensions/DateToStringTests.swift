//
//  DateToStringTests.swift
//  YCalendarPicker
//
//  Created by Sanjib Chakraborty on 20/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YCalendarPicker

final class DateToStringTests: XCTestCase {
    func test_toStringWithFormatType() {
        let timeZone = TimeZone(abbreviation: "IST")
        XCTAssertNotNil(timeZone)

        let sut: Date! = Calendar.current.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        XCTAssertNotNil(sut)

        var string: String?

        // format string - "MM/dd/yyyy"
        string = sut.toString(withFormatType: DateFormatType.MMddyyyy(separator: "/"))
        XCTAssertEqual(string, "06/05/2022")

        // format string - "dd-MM-yyyy"
        string = sut.toString(withFormatType: DateFormatType.ddMMyyyy(separator: "-"))
        XCTAssertEqual(string, "05-06-2022")

        // format string - "yyyy"
        string = sut.toString(withFormatType: DateFormatType.yyyy)
        XCTAssertEqual(string, "2022")

        // format string - "MMMM"
        string = sut.toString(withFormatType: DateFormatType.MMMM)
        XCTAssertEqual(string, "June")

        // format string - "EEEE"
        string = sut.toString(withFormatType: DateFormatType.EEEE)
        XCTAssertEqual(string, "Sunday")

        // format string - "yyyyMMddZ"
        string = sut.toString(withFormatType: DateFormatType.yyyyMMddZ, timeZone: timeZone)
        XCTAssertEqual(string, "20220605+0530")

        // format string - "HH_mm_ss"
        string = sut.toString(withFormatType: DateFormatType.HHmmss(separator: ":"), timeZone: timeZone)
        XCTAssertEqual(string, "10:42:52")

        // format string - "HH_mm"
        string = sut.toString(withFormatType: DateFormatType.HHmm(separator: ":"), timeZone: timeZone)
        XCTAssertEqual(string, "10:42")

        // format string - yy_MM_dd
        string = sut.toString(withFormatType: DateFormatType.yyMMdd(separator: "-"))
        XCTAssertEqual(string, "22-06-05")

        // format string - MM_dd_yy
        string = sut.toString(withFormatType: DateFormatType.MMddyy(separator: "-"))
        XCTAssertEqual(string, "06-05-22")

        // format string - yyyy_MM_dd
        string = sut.toString(withFormatType: DateFormatType.yyyyMMdd(separator: "-"))
        XCTAssertEqual(string, "2022-06-05")

        // format string - dd_MM_yyyy
        string = sut.toString(withFormatType: DateFormatType.ddMMyyyy(separator: "-"))
        XCTAssertEqual(string, "05-06-2022")

        // format string - dd_MM_yy
        string = sut.toString(withFormatType: DateFormatType.ddMMyy(separator: "-"))
        XCTAssertEqual(string, "05-06-22")

        // format string - yyyy_MM
        string = sut.toString(withFormatType: DateFormatType.yyyyMM(separator: "-"))
        XCTAssertEqual(string, "2022-06")
    }

    func test_toStringWithFormatTypeCustom() {
        let timeZone = TimeZone(abbreviation: "IST")
        XCTAssertNotNil(timeZone)
        
        let sut: Date! = Calendar.current.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        XCTAssertNotNil(sut)

        var string: String?

        // format string - "yyyy-MM-dd'T'HH:mmZ"
        string = sut.toString(withFormatType: DateFormatType.custom(format: "yyyy-MM-dd'T'HH:mmZ"), timeZone: timeZone)
        XCTAssertEqual(string, "2022-06-05T10:42+0530")

        // format string - "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        string = sut.toString(
            withFormatType: DateFormatType.custom(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ"),
            timeZone: timeZone
        )
        XCTAssertEqual(string, "2022-06-05T10:42:52.000+0530")

        // format string - "EEE, d MMM yyyy HH:mm:ss ZZZ". HTTP header date format
        string = sut.toString(withFormatType: DateFormatType.httpHeader, timeZone: timeZone)
        XCTAssertEqual(string, "Sun, 5 Jun 2022 10:42:52 +0530")

        // format string - "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        string = sut.toString(
            withFormatType: DateFormatType.custom(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ"),
            timeZone: timeZone
        )
        XCTAssertEqual(string, "2022-06-05T10:42:52+05:30")

        // format string - "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        string = sut.toString(
            withFormatType: DateFormatType.custom(
                format: "yyyy_MM_dd'T'HH:mm:ssZZZZZ",
                separator: "-"
            ),
            timeZone: timeZone
        )
        XCTAssertEqual(string, "2022-06-05T10:42:52+05:30")

        // format string - "dd MMM yyyy, h:mm a"
        string = sut.toString(withFormatType: DateFormatType.custom(format: "dd MMM yyyy, h:mm a"), timeZone: timeZone)
        XCTAssertEqual(string?.lowercased(), "05 Jun 2022, 10:42 AM".lowercased())

        // format string - "dd MMM yyyy, h:mm a" in PST timezone
        string = sut.toString(
            withFormatType: DateFormatType.custom(format: "dd MMM yyyy, h:mm a"),
            timeZone: TimeZone(abbreviation: "PST")
        )
        XCTAssertEqual(string?.lowercased(), "04 Jun 2022, 10:12 PM".lowercased())
    }

    func test_toStringWithFormatTypeISO() {
        let timeZone = TimeZone(abbreviation: "IST")
        XCTAssertNotNil(timeZone)
    
        let sut: Date! = Calendar.current.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        XCTAssertNotNil(sut)

        var string: String?

        // format string - isoYear - "yyyy"
        string = sut.toString(withFormatType: DateFormatType.isoYear)
        XCTAssertEqual(string, "2022")

        // format string - isoYearMonth - "yyyy-MM"
        string = sut.toString(withFormatType: DateFormatType.isoYearMonth)
        XCTAssertEqual(string, "2022-06")

        // format string - isoDate - "yyyy-MM-dd"
        string = sut.toString(withFormatType: DateFormatType.isoDate)
        XCTAssertEqual(string, "2022-06-05")

        // format string - isoDateTime - "yyyy-MM-dd'T'HH:mm:ssZ"
        string = sut.toString(withFormatType: DateFormatType.isoDateTime, timeZone: timeZone)
        XCTAssertEqual(string, "2022-06-05T10:42:52+0530")

        // format string - isoDateTimeFull - "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        string = sut.toString(withFormatType: DateFormatType.isoDateTimeFull, timeZone: timeZone)
        XCTAssertEqual(string, "2022-06-05T10:42:52.000+0530")
    }

    func test_toStringWithFormatTypeJulianDay() {
        let timeZone = TimeZone(abbreviation: "IST")
        XCTAssertNotNil(timeZone)
        
        let sut: Date! = Calendar.current.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        XCTAssertNotNil(sut)

        var string: String?

        // format string - yy_DDD
        string = sut.toString(withFormatType: DateFormatType.yyDDD(separator: "-"))
        XCTAssertEqual(string, "22-156")

        // format string - DDD_yy
        string = sut.toString(withFormatType: DateFormatType.DDDyy(separator: "-"))
        XCTAssertEqual(string, "156-22")

        // format string - yyyy_DDD
        string = sut.toString(withFormatType: DateFormatType.yyyyDDD(separator: "-"))
        XCTAssertEqual(string, "2022-156")

        // format string - DDD_yyyy
        string = sut.toString(withFormatType: DateFormatType.DDDyyyy(separator: "-"))
        XCTAssertEqual(string, "156-2022")
    }

    func test_toStringWithFormatTypeThreeLetterAbbreviationOfTheMonth() {
        let timeZone = TimeZone(abbreviation: "IST")
        XCTAssertNotNil(timeZone)

        let sut: Date! = Calendar.current.date(
            from: DateComponents(timeZone: timeZone, year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        XCTAssertNotNil(sut)

        var string: String?

        // format string - yy_MMM_dd
        string = sut.toString(withFormatType: DateFormatType.yyMMMdd(separator: "-"))
        XCTAssertEqual(string, "22-Jun-05")

        // format string - dd_MMM_yy
        string = sut.toString(withFormatType: DateFormatType.ddMMMyy(separator: "-"))
        XCTAssertEqual(string, "05-Jun-22")

        // format string - MMM_dd_yy
        string = sut.toString(withFormatType: DateFormatType.MMMddyy(separator: "-"))
        XCTAssertEqual(string, "Jun-05-22")

        // format string - yyyy_MMM_dd
        string = sut.toString(withFormatType: DateFormatType.yyyyMMMdd(separator: "-"))
        XCTAssertEqual(string, "2022-Jun-05")

        // format string - dd_MMM_yyyy
        string = sut.toString(withFormatType: DateFormatType.ddMMMyyyy(separator: "-"))
        XCTAssertEqual(string, "05-Jun-2022")

        // format string - MMM_dd_yyyy
        string = sut.toString(withFormatType: DateFormatType.MMMddyyyy(separator: "-"))
        XCTAssertEqual(string, "Jun-05-2022")
    }
    
    func test_toStringWithTemplate() {
        let locale = Locale(identifier: "en_GB")

        let sut: Date! = Calendar.current.date(
            from: DateComponents(year: 2022, month: 06, day: 05, hour: 10, minute: 42, second: 52)
        )
        XCTAssertNotNil(sut)

        var string: String?

        // Template - "ddMMyyyyHHmmss"
        string = sut.toString(withTemplate: "ddMMyyyyHHmmss", locale: locale)
        XCTAssertEqual(string, "05/06/2022, 10:42:52")

        // Template - "ddMMMyyyy"
        string = sut.toString(withTemplate: "ddMMMyyyy", locale: locale)
        XCTAssertEqual(string, "05 Jun 2022")
    }
}
                               
