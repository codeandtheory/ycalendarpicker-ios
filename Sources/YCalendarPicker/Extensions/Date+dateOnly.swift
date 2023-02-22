//
//  Date+dateOnly.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 07/12/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.

import Foundation

/// Add `dateOnly` computed property
extension Date {
    /// Returns a new `Date` representing the date calculated by setting hour, minute, and second
    /// to zero on a specified `Date` using the local time zone.
    public var dateOnly: Date {
        Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self) ?? self
    }
}
