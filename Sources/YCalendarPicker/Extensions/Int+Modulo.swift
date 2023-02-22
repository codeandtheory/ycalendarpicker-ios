//
//  Int+Modulo.swift
//  YCalendarPicker
//
//  Created by Mark Pospesel on 1/19/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.

import Foundation

extension Int {
    /// Performs the modulus (not the remainder) operation on the receiver.
    ///
    /// `%` is the remainder operator in Swift and not the modulus operator.
    /// They return the same results for positive numbers, but they differ for negative numbers.
    ///
    /// -1 % 7 = -1 (remainder)
    ///
    /// -1 mod 7 = 6 (modulus)
    /// - Parameter divisor: the number to divide by
    /// - Returns: The modulus, whcih is guaranteed to be in the range of `0..<divisor`
    public func modulo(_ divisor: Int) -> Int {
        // % is not a modulo operator in Swift
        // but rather a remainder operator.
        // The following expression ensures that
        // the return value is in the range 0..<divisor
        (self % divisor + divisor) % divisor
    }
}
