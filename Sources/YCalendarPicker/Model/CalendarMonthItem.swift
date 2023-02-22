//
//  CalendarMonthItem.swift
//  YCalendarPicker
//
//  Created by Parv Bhaskar on 20/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

/// Information about a single day in a month.
/// Intended as an aid for rendering a month calendar view.
public struct CalendarMonthItem: Equatable {
    /// The day of the month (e.g. "15")
    public let day: String
    
    /// The numeric month  (e.g. "6")
    public let month: String
    
    /// The numeric year (e.g. "2022")
    public let year: String
    
    /// Date (without a time component)
    public let date: Date
    
    /// Whether `date` lies outside of the current month.
    /// (e.g. In June 2022, dates from 29th May to 31st May and 1st July to 9th july)
    public let isGrayedOut: Bool
    
    /// Whether `date` is today.
    /// (e.g. current date is 21st June 2022 then this value is true for that date only)
    public let isToday: Bool
    
    /// Optional additional notes
    public let note: String?
    
    /// Whether the date is selected
    public var isSelected: Bool
    
    /// Whether the date should be enabled.
    ///
    /// Set to `false` if `date` falls outside the range of valid dates (e.g. not allowing past dates).
    public var isEnabled: Bool
    
    /// Whether the date has already been booked.
    ///
    /// A booked date is not selectable in the month calendar.
    public var isBooked: Bool

    /// Initializes a calendar month item.
    /// - Parameters:
    ///   - date: date (any time component will be removed)
    ///   - isGrayedOut: whether `date` lies outside of the current month
    ///   - note: optional additional notes
    ///   - isSelected: whether the date is selected
    ///   - isEnabled: whether the date should be enabled
    ///   - isBooked: whether the date has already been booked
    public init(
        date: Date,
        isGrayedOut: Bool,
        note: String? = nil,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        isBooked: Bool = false
    ) {
        self.day = date.get(.day)
        self.month = date.get(.month)
        self.year = date.get(.year)
        self.date = date.dateOnly
        self.isGrayedOut = isGrayedOut
        self.isToday = date.isToday
        self.note = note
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.isBooked = isBooked
    }
}

extension CalendarMonthItem {
    /// Returns `true` if the date can be selected in a month calendar, otherwise `false`.
    public var isSelectable: Bool { isEnabled && !isBooked }
}
