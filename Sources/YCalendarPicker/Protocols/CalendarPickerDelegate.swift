//
//  CalendarPickerDelegate.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 03/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
/// Protocol to observe changes in month
public protocol CalendarPickerDelegate: AnyObject {
    /// Observe changes in month (Next/Previous).
    /// Called after the user changes the month.
    func calendarPicker(_ calendarPicker: CalendarPicker, didChangeMonthTo date: Date)
}
