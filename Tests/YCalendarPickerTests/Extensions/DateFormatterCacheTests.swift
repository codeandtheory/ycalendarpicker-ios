//
//  DateToStringTests.swift
//  YCalendarPicker
//
//  Created by Sanjib Chakraborty on 06/07/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class DateFormatterCacheTests: XCTestCase {
    private var sut: DateFormatterCache!

    override func setUp() {
        super.setUp()

        sut = DateFormatterCache.current
        sut.removeAllCachedDateFormatters()
    }

    override func tearDown() {
        super.tearDown()

        sut.removeAllCachedDateFormatters()
    }

    func testDateFormatterCache() {
        XCTAssertEqual(sut.cachedDateFormattersCount, 0)

        _ = sut.cachedDateFormatter(format: "MM/dd/yyyy")
        XCTAssertEqual(sut.cachedDateFormattersCount, 1)

        // Use same format, so that count will not be increased
        _ = sut.cachedDateFormatter(format: "MM/dd/yyyy")
        XCTAssertEqual(sut.cachedDateFormattersCount, 1)

        // Use different format, so that count will be increased
        _ = sut.cachedDateFormatter(format: "dd-MM-yyyy")
        XCTAssertEqual(sut.cachedDateFormattersCount, 2)

        sut.removeAllCachedDateFormatters()
        XCTAssertEqual(sut.cachedDateFormattersCount, 0)
    }

    func testTemplateDateFormatterCache() {
        XCTAssertEqual(sut.cachedDateFormattersCount, 0)

        _ = sut.cachedTemplateDateFormatter(template: "ddMMMyyyy")
        XCTAssertEqual(sut.cachedDateFormattersCount, 1)

        // Use same template, so that count will not be increased
        _ = sut.cachedTemplateDateFormatter(template: "ddMMMyyyy")
        XCTAssertEqual(sut.cachedDateFormattersCount, 1)

        // Use different template, so that count will be increased
        _ = sut.cachedTemplateDateFormatter(template: "ddMMyyyyHHmmss")
        XCTAssertEqual(sut.cachedDateFormattersCount, 2)

        sut.removeAllCachedDateFormatters()
        XCTAssertEqual(sut.cachedDateFormattersCount, 0)
    }

    func testMixedDateFormatterCache() {
        XCTAssertEqual(sut.cachedDateFormattersCount, 0)

        _ = sut.cachedTemplateDateFormatter(template: "ddMMMyyyy")
        XCTAssertEqual(sut.cachedDateFormattersCount, 1)

        // Use same template, so that count will not be increased
        _ = sut.cachedTemplateDateFormatter(template: "ddMMMyyyy")
        XCTAssertEqual(sut.cachedDateFormattersCount, 1)

        // Use different template, so that count will be increased
        _ = sut.cachedTemplateDateFormatter(template: "ddMMyyyyHHmmss")
        XCTAssertEqual(sut.cachedDateFormattersCount, 2)
        
        // Use same template but as a format, so that count will be increased
        _ = sut.cachedDateFormatter(format: "ddMMyyyyHHmmss")
        XCTAssertEqual(sut.cachedDateFormattersCount, 3)
        
        let cachedTemplateFormatterCount = sut.cachedDateFormatters.keys.filter { $0.hasPrefix("template") }.count
        XCTAssertEqual(cachedTemplateFormatterCount, 2)

        sut.removeAllCachedDateFormatters()
        XCTAssertEqual(sut.cachedDateFormattersCount, 0)
    }

    func testTemplateFormatterCacheMixedLocale() {
        XCTAssertEqual(sut.cachedDateFormattersCount, 0)

        _ = sut.cachedTemplateDateFormatter(template: "ddMMMyyyy")
        XCTAssertEqual(sut.cachedDateFormattersCount, 1)

        // Use same template but passing current locale should not increase
        _ = sut.cachedTemplateDateFormatter(template: "ddMMMyyyy", locale: .current)
        XCTAssertEqual(sut.cachedDateFormattersCount, 1)

        // Use different locale, so that count will be increased
        let otherIdentifier = (Locale.current.identifier == "de_CH") ? "en_GB" : "de_CH"
        let otherLocale = Locale(identifier: otherIdentifier)
        _ = sut.cachedTemplateDateFormatter(template: "ddMMMyyyy", locale: otherLocale)
        XCTAssertEqual(sut.cachedDateFormattersCount, 2)

        sut.removeAllCachedDateFormatters()
        XCTAssertEqual(sut.cachedDateFormattersCount, 0)
    }
}

extension DateFormatterCache {
    var cachedDateFormattersCount: Int {
        cachedDateFormatters.keys.count
    }

    func removeAllCachedDateFormatters() {
        cachedDateFormatters.removeAll()
    }
}
