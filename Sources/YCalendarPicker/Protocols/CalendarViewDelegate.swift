//
//  CalendarViewDelegate.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 07/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
/// Protocol to observe changes in date(s)
public protocol CalendarViewDelegate: AnyObject {
    /// Method for change in selected date.
    /// Called after the user changes the selection.
    /// - Parameter date: new selected date.
    func calendarViewDidSelectDate(_ date: Date?)
    /// Method for change in month.
    /// Called after the user changes the selection.
    /// - Parameter date: next/previous month(s) date from today
    func calendarViewDidChangeMonth(to date: Date)
}
