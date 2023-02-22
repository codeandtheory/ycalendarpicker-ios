//
//  Int+ModulusTests.swift
//  YCalendarPicker
//
//  Created by Mark Pospesel on 1/19/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest

final class IntModulusTests: XCTestCase {
    func test_modulo_equalsRemainderForPositiveNumbers() {
        let divisor = Int.random(in: 5...10)
        for i in 0...(divisor * 5) {
            XCTAssertEqual(i % divisor, i.modulo(divisor))
        }
    }

    func test_modulo_differsFromRemainderForManyNegativeNumbers() {
        let divisor = Int.random(in: 5...10)
        for i in -100..<0 where i % divisor != 0 {
            XCTAssertNotEqual(i % divisor, i.modulo(divisor))
        }
    }

    func test_modulo_worksForNegativeNumbers() {
        XCTAssertEqual((-1).modulo(7), 6)
        XCTAssertEqual((-2).modulo(7), 5)
        XCTAssertEqual((-7).modulo(7), 0)
        XCTAssertEqual((-10).modulo(7), 4)

        XCTAssertEqual((-81).modulo(9), 0)
    }

    func test_modulo_returnsValuesInTheCorrectRange() {
        let divisor = Int.random(in: 3...7)
        for i in -100...100 {
            let mod = i.modulo(divisor)
            XCTAssertGreaterThanOrEqual(mod, 0)
            XCTAssertLessThan(mod, divisor)
        }
    }
}
