//
//  Date+dateWithTime.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 27/07/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
/// Add `dateWithTime` computed property
extension Date {
    /// Returns a new `Date` representing the date calculated by setting hour, minute, and second
    /// to current values on a specified `Date` using the local time zone.
    public var dateWithTime: Date? {
        let currentDate = Date()
        let hours = Calendar.current.component(.hour, from: currentDate)
        let minutes = Calendar.current.component(.minute, from: currentDate)
        let seconds = Calendar.current.component(.second, from: currentDate)

        return Calendar.current.date(bySettingHour: hours, minute: minutes, second: seconds, of: self)
    }
}
