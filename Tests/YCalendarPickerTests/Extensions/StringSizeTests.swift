//
//  StringSizeTests.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 07/12/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class StringSizeTests: XCTestCase {
    func testEmptyStringSize() {
        let size = "".size(of: .boldSystemFont(ofSize: 2))
        XCTAssertEqual(size.width, 0)
        XCTAssertGreaterThan(size.height, 0)
    }
    
    func testNonEmptyStringSize() {
        let size = "3".size(of: .boldSystemFont(ofSize: 20))
        XCTAssertGreaterThan(size.width, 0)
        XCTAssertGreaterThan(size.height, 0)
    }
    
    func testStringSizeOfTwoStrings() {
        let biggerSize = "30".size(of: .boldSystemFont(ofSize: 20))
        let smallerSize = "1".size(of: .boldSystemFont(ofSize: 20))
        XCTAssertGreaterThan(biggerSize.width, smallerSize.width)
        XCTAssertEqual(biggerSize.height, smallerSize.height)
    }
}
