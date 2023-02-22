//
//  XCTestCase+TypographyTest.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 08/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
import YMatterType

extension XCTestCase {
    func XCTAssertTypographyEqual(_ expression1: Typography, _ expression2: Typography) {
        XCTAssertEqual(expression1.fontFamily.familyName, expression2.fontFamily.familyName)
        XCTAssertEqual(expression1.fontFamily.fontNameSuffix, expression2.fontFamily.fontNameSuffix)
        XCTAssertEqual(expression1.fontWeight, expression2.fontWeight)
        XCTAssertEqual(expression1.fontSize, expression2.fontSize)
        XCTAssertEqual(expression1.lineHeight, expression2.lineHeight)
        XCTAssertEqual(expression1.textCase, expression2.textCase)
        XCTAssertEqual(expression1.textDecoration, expression2.textDecoration)
        XCTAssertEqual(expression1.textStyle, expression2.textStyle)
        XCTAssertEqual(expression1.isFixed, expression2.isFixed)
    }
}
