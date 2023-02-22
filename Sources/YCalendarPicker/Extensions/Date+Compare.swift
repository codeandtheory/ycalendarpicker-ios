//
//  Date+Compare.swift
//  YCalendarPicker
//
//  Created by Parv Bhaskar on 15/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

/// A date extension with helper variables to check and compare.
/// A good choice where we need to check if the selected date belongs to a particular
/// segment (e.g. current month, next week, last year, etc.).
public extension Date {
    /// Returns `true` if the given date is within yesterday, as defined by the calendar and calendar's locale.
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    /// Returns `true` if the given date is within today, as defined by the calendar and calendar's locale.
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
        
    /// Returns `true` if the given date is within tomorrow, as defined by the calendar and calendar's locale.
    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    /// Returns `true` if the given date is within last week, as defined by the calendar and calendar's locale.
    var isLastWeek: Bool {
        guard let previousWeek = Calendar.current.date(
            byAdding: .weekOfYear,
            value: -1,
            to: Date()
        ) else { return false }
        
        return Calendar.current.isDate(self, equalTo: previousWeek, toGranularity: .weekOfYear)
    }

    /// Returns `true` if the given date is within current week, as defined by the calendar and calendar's locale.
    var isThisWeek: Bool {
        isSameWeek(as: Date())
    }
        
    /// Returns `true` if the given date is within next week, as defined by the calendar and calendar's locale.
    var isNextWeek: Bool {
        guard let nextWeek = Calendar.current.date(
            byAdding: .weekOfYear,
            value: 1,
            to: Date()
        ) else { return false }
        
        return Calendar.current.isDate(self, equalTo: nextWeek, toGranularity: .weekOfYear)
    }
        
    /// Returns `true` if the given date is within last month, as defined by the calendar and calendar's locale.
    var isLastMonth: Bool {
        guard let previousMonth = Calendar.current.date(
            byAdding: .month,
            value: -1,
            to: Date()
        ) else { return false }
        
        return Calendar.current.isDate(self, equalTo: previousMonth, toGranularity: .month)
    }
    
    /// Returns `true` if the given date is within current month, as defined by the calendar and calendar's locale.
    var isThisMonth: Bool {
        isSameMonth(as: Date())
    }
    
    /// Returns `true` if the given date is within next month, as defined by the calendar and calendar's locale.
    var isNextMonth: Bool {
        guard let nextMonth = Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: Date()
        ) else { return false }
        
        return Calendar.current.isDate(self, equalTo: nextMonth, toGranularity: .month)
    }

    /// Returns `true` if the given date is within last year, as defined by the calendar and calendar's locale.
    var isLastYear: Bool {
        guard let lastYear = Calendar.current.date(
            byAdding: .year,
            value: -1,
            to: Date()
        ) else { return false }
        
        return Calendar.current.isDate(self, equalTo: lastYear, toGranularity: .year)
    }

    /// Returns `true` if the given date is within current year, as defined by the calendar and calendar's locale.
    var isThisYear: Bool {
        isSameYear(as: Date())
    }

    /// Returns `true` if the given date is within next year, as defined by the calendar and calendar's locale.
    var isNextYear: Bool {
        guard let nextYear = Calendar.current.date(
            byAdding: .year,
            value: 1,
            to: Date()
        ) else { return false }
        
        return Calendar.current.isDate(self, equalTo: nextYear, toGranularity: .year)
    }
    
    /// Determines whether two dates both fall on the same day.
    /// - Parameter otherDate: the other date which need to be compared with selected date.
    /// - Returns: `true` when both dates  fall on the same day.
    func isSameDay(as otherDate: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: otherDate, toGranularity: .day)
    }
    
    /// Determines whether two dates both fall on the same week.
    /// - Parameter otherDate: the other date which need to be compared with selected date.
    /// - Returns: `true` when both dates  fall on the same week..
    func isSameWeek(as otherDate: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: otherDate, toGranularity: .weekOfYear)
    }

    /// Determines whether two dates both fall on the same month.
    /// - Parameter otherDate: the other date which need to be compared with selected date.
    /// - Returns: `true` when both dates  fall on the same month..
    func isSameMonth(as otherDate: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: otherDate, toGranularity: .month)
    }
    
    /// Determines whether two dates both fall on the same year.
    /// - Parameter otherDate: the other date which need to be compared with selected date.
    /// - Returns: `true` when both dates  fall on the same year..
    func isSameYear(as otherDate: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: otherDate, toGranularity: .year)
    }
}
