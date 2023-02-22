//
//  Date+CalendarDates.swift
//  YCalendarPicker
//
//  Created by Parv Bhaskar on 20/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

/// A date extension with helper function to get all the dates for a selected month.
/// A good choice where we need to show all the dates of a particular month on the calendar view.
/// segment (e.g. getDatesForSelectedMonth).
extension Date {
    /// Returns `42` total number of date tiles to be displayed for selected date.
    private static let numberOfDateTiles = 42
    
    /// Returns `[CalendarMonthItem]` gives all the dates for selected month dates that need to be
    /// shown in current month date calendar (eg. for June 2022, it will give dates from (29th May to 9th July)).
    public func getAllDatesForSelectedMonth(firstWeekIndex: Int) -> [CalendarMonthItem] {
        let previousMonthDates = getPreviousMonthDates(firstWeekIndex: firstWeekIndex)
        let selectedMonthDates = getSelectedMonthDates()
        let nextMonthDates = getNextMonthDates(firstWeekIndex: firstWeekIndex)

        return previousMonthDates + selectedMonthDates + nextMonthDates
    }

    /// Returns start `Date` of the given date.
    public func startDateOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components) ?? self
    }

    /// Returns end `Date` of the given date.
    public func endDateOfMonth() -> Date {
        var components = DateComponents()
        components.month = 1
        components.day = -1
        return Calendar.current.date(byAdding: components, to: startDateOfMonth()) ?? self
    }

    /// Returns a `Int` number of days for selected month.
    public func numberOfDaysInMonth() -> Int {
        guard let range = Calendar.current.range(of: .day, in: .month, for: self) else { return .zero }
        return range.count
    }

    /// Returns previous `Date` of the given date.
    public func previousDate() -> Date {
        date(byAddingDays: -1) ?? self
    }

    /// Returns next `Date` of the given date.
    public func nextDate() -> Date {
        date(byAddingDays: 1) ?? self
    }

    /// Returns a `Date` created by adding/removing the number of days.
    /// - Parameter count: The number of days. Provide negative value to subtract days.
    /// - Returns: A new `Date` by adding  number of days.
    public func date(byAddingDays count: Int) -> Date? {
        Calendar.current.date(byAdding: .day, value: count, to: self)
    }

    /// Returns a `Date` created by adding/removing the number of months.
    /// - Parameter count: The number of months. Provide negative value to go back to previous month(s).
    /// - Returns: A new `Date` by adding  number of months.
    public func date(byAddingMonth count: Int) -> Date? {
        Calendar.current.date(byAdding: .month, value: count, to: self)
    }

    /// Returns a `Date` created by adding/removing the number of years.
    /// - Parameter count: The number of years. Provide negative value to go back to previous year(s).
    /// - Returns: A new `Date` by adding  number of years.
    public func date(byAddingYear count: Int) -> Date? {
        Calendar.current.date(byAdding: .year, value: count, to: self)
    }
    
    // MARK: - Helpers

    /// Returns `Int` it tells the weekday of selected day
    ///  (eg. 5(Thursday.) for 2nd June 2022, 6(Friday) for July 2022).
    internal func indexOfWeekday() -> Int? {
        Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    /// Returns `[CalendarMonthItem]` gives the previous month custom model
    /// dates that need to be shown in current month date calendar (eg. for June 2022,
    /// it will give dates from (29 May to 31st May)).
    internal func getPreviousMonthDates(firstWeekIndex: Int) -> [CalendarMonthItem] {
        let startDate = startDateOfMonth()
        guard var startDateWeekday = startDate.indexOfWeekday() else { return [] }
        startDateWeekday -=  firstWeekIndex
        
        var previousMonthDates = [CalendarMonthItem]()
        var currentDate = startDate
        
        if startDateWeekday <= firstWeekIndex {
            startDateWeekday = 7+startDateWeekday
        }
        
        for _ in 1..<startDateWeekday {
            let previousDate = currentDate.previousDate()
            previousMonthDates.insert(previousDate.toCalendarItem(isGrayedOut: true), at: .zero)
            currentDate = previousDate
        }
        
        return previousMonthDates
    }
    
    /// Returns `[CalendarMonthItem]` gives the next month custom model
    /// dates that need to be shown in current month date calendar (eg. for June 2022,
    ///  it will give dates from (1st July to 9th July)).
    internal func getNextMonthDates(firstWeekIndex: Int) -> [CalendarMonthItem] {
        var nextMonthDates = [CalendarMonthItem]()
        var currentDate = endDateOfMonth()
        
        for _ in 1...getNumberOfFutureDatesRequired(firstWeekIndex: firstWeekIndex) {
            let nextDate = currentDate.nextDate()
            nextMonthDates.append(nextDate.toCalendarItem(isGrayedOut: true))
            currentDate = nextDate
        }

        return nextMonthDates
    }
    
    /// Returns `[CalendarMonthItem]` gives the selected month custom model
    /// dates that need to be shown in current month date calendar (eg. for June 2022,
    /// it will give dates from (1st June to 30th June)).
    internal func getSelectedMonthDates() -> [CalendarMonthItem] {
        let startDate = startDateOfMonth()
        let totalDays = numberOfDaysInMonth()
        
        var selectedMonthDates = [startDate.toCalendarItem(isGrayedOut: false)]
        var currentDate = startDate
        
        for _ in 1..<totalDays {
            let nextDate = currentDate.nextDate()
            selectedMonthDates.append(nextDate.toCalendarItem(isGrayedOut: false))
            currentDate = nextDate
        }
        
        return selectedMonthDates
    }

    /// Returns `String` gives the string value back as per the date component provided.
    /// - Parameter `Calendar.Component`:  according to the date component value will get calculated.
    internal func get(_ component: Calendar.Component) -> String {
        "\(Calendar.current.component(component, from: self))"
    }

    /// Returns `CalendarMonthItem` gives the custom date model as per the selected date item.
    /// - Parameter `isGrayedOut`:  tell us that the date is from the active month or not.
    internal func toCalendarItem(
        isGrayedOut: Bool = false,
        isSelected: Bool = false,
        isEnabled: Bool = true,
        isBooked: Bool = false
    ) -> CalendarMonthItem {
        CalendarMonthItem(
            date: self,
            isGrayedOut: isGrayedOut,
            isSelected: isSelected,
            isEnabled: isEnabled,
            isBooked: isBooked
        )
    }
    
    /// Returns `Int` gives the number of future dates to fill current calendar view.
    private func getNumberOfFutureDatesRequired(firstWeekIndex: Int) -> Int {
        let numberOfDateTiles = Date.numberOfDateTiles
        let numberOfPreviousMonthDates = getPreviousMonthDates(firstWeekIndex: firstWeekIndex).count
        let numberOfSelectedMonthDates = numberOfDaysInMonth()
        
        return numberOfDateTiles - (numberOfPreviousMonthDates + numberOfSelectedMonthDates)
    }
}
