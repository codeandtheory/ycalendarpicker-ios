//
//  YCalendarPickerDelegate.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 03/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
/// Protocol to observe changes in month
public protocol YCalendarPickerDelegate: AnyObject {
    /// Observe changes in month (Next/Previous).
    /// Called after the user changes the month.
    func calendarPicker(_ calendarPicker: YCalendarPicker, didChangeMonthTo date: Date)
}
