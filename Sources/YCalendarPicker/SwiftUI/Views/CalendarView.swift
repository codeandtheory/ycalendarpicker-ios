//
//  CalendarView.swift
//  YCalendarPicker
//
//  Created by Sahil on 28/10/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import SwiftUI

/// Swift UI month calendar picker
///
/// Renamed to `CalendarView`.
@available(*, deprecated, renamed: "CalendarView")
public typealias YCalendarView = CalendarView

/// Swift UI month calendar picker
public struct CalendarView {
    /// Unique identifier
    ///
    /// This facilitates connection between SwiftUI & UIKit layers
    internal let reuseIdentifier = UUID()

    @State internal var currentDate = Date().startDateOfMonth()

    // Observes appearance changes
    @ObservedObject private var appearanceObserver = AppearanceObserver()
    @ObservedObject private var dateObserver = DateObserver()
    var headerDateFormat: String = "MMMMyyyy"
    var firstWeekday: Int = Locale.current.calendar.firstWeekday
    var locale: Locale = Locale.current
    /// Delegate for date/month change
    weak public var delegate: CalendarViewDelegate?

    /// Selected date (if any)
    public var date: Date? {
        get {
            self.dateObserver.date
        }
        set {
            self.dateObserver.date = newValue?.dateOnly
        }
    }
    
    /// Start date (if any)
    public var startDate: Date?
    
    /// Calendar appearance
    public var appearance: CalendarPicker.Appearance {
        get {
            self.appearanceObserver.appearance
        }
        set {
            self.appearanceObserver.appearance = newValue
        }
    }
    
    /// Optional minimum date. Dates before the minimum cannot be selected. `nil` means no minimum (default).
    public var minimumDate: Date? {
        get {
            dateObserver.minimumDate
        }
        set {
            dateObserver.minimumDate = newValue?.dateOnly
            onMinimumDateChanged()
        }
    }

    /// Optional maximum date. Dates beyond the maximum cannot be selected. `nil` means no maximum (default).
    public var maximumDate: Date? {
        get {
            self.dateObserver.maximumDate
        }
        set {
            dateObserver.maximumDate = newValue?.dateOnly
            onMaximumDateChanged()
        }
    }
    
    /// Optional booked dates. These dates cannot be selected.
    public var bookedDates: [Date] {
        get {
            dateObserver.bookedDates
        }
        set {
            dateObserver.bookedDates = newValue.map { $0.dateOnly }
            onBookedDateChanged()
        }
    }
    
    /// Initializes a SwiftUI Calendar picker
    /// - Parameters:
    ///   - firstWeekday: first day of week. Default is `nil`.
    ///   - appearance: appearance of calendar view. Default is `Appearance.default`.
    ///   - minimumDate: minimum date to enable. Default is `nil`.
    ///   - maximumDate: maximum date to enable. Default is `nil`.
    ///   - startDate: start date of the calendar. Default is `nil`.
    ///   - locale: locale for data formatting e.g Date format. Default is `nil`.
    public init(
        firstWeekday: Int? = nil,
        appearance: CalendarPicker.Appearance = .default,
        minimumDate: Date? = nil,
        maximumDate: Date? = nil,
        startDate: Date? = nil,
        locale: Locale? = nil
    ) {
        self.firstWeekday = firstWeekday ?? (Locale.current.calendar.firstWeekday - 1)
        self.appearance = appearance
        self.minimumDate = minimumDate?.dateOnly
        self.maximumDate = maximumDate?.dateOnly
        self.locale = locale ?? Locale.current
        self.startDate = startDate?.startDateOfMonth()
    }
}

extension CalendarView: View {
    /// :nodoc:
    public var body: some View {
        VStack(spacing: 0) {
            getMonthView()
            getWeekdayView()
            getDaysView()
        }.gesture(
            DragGesture().onEnded({ value in
                currentDate = getCurrentDateAfterSwipe(swipeValue: value.translation)
            })
        )
        .background(Color(self.appearance.backgroundColor))
        .onAppear(perform: {
            if let getStartDate = self.startDate {
                currentDate = getStartDate
            }
        })
    }
    
    @ViewBuilder
    func getMonthView() -> some View {
        MonthView(
            currentDate: $currentDate,
            appearance: appearance,
            dateFormat: headerDateFormat,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            locale: locale
        )
    }

    @ViewBuilder
    func getWeekdayView() -> some View {
        WeekdayView(firstWeekday: firstWeekday, appearance: appearance, locale: locale)
    }

    func getDaysView() -> some View {
        var allDates = currentDate.getAllDatesForSelectedMonth(firstWeekIndex: firstWeekday.modulo(7))
        allDates = allDates.map { dateItem -> CalendarMonthItem in
            var newItem = dateItem
            if isBooked(dateItem.date) {
                newItem.isBooked = true
                newItem.isEnabled = false
            } else {
                newItem.isEnabled = shouldEnableDate(dateItem.date, minimumDate: minimumDate, maximumDate: maximumDate)
            }
            return newItem
        }
        
        let selectedDate = Binding(
            get: { dateObserver.date },
            set: { dateObserver.date = $0?.dateOnly }
        )
        
        return DaysView(
            allDates: allDates,
            appearance: appearance,
            selectedDate: selectedDate,
            locale: locale,
            currentDate: currentDate
        )
        .onChange(of: date) { newValue in
            selectedDateDidChange(newValue?.dateOnly)
        }
        .onChange(of: currentDate) { newValue in
            monthDidChange(newValue.dateOnly)
        }
    }
}

extension CalendarView {
    func isDateBeforeMinimumDate(_ date: Date?) -> Bool {
        guard let date = date,
              let minDate = minimumDate else { return false }

        return date < minDate
    }

    mutating func onMinimumDateChanged() {
        if isDateBeforeMinimumDate(date) {
            date = nil
        }
    }
    
    func isDateAfterMaximumDate(_ date: Date?) -> Bool {
        guard let date = date,
              let maxDate = maximumDate else { return false }
        
        return date > maxDate
    }
    
    mutating func onMaximumDateChanged() {
        if isDateAfterMaximumDate(date) {
            date = nil
        }
    }
    
    func isBooked(_ dateItem: Date?) -> Bool {
        guard let dateItem = dateItem else { return false }
        return bookedDates.contains(dateItem.dateOnly)
    }
    
    mutating func onBookedDateChanged() {
        if isBooked(date) {
            date = nil
        }
    }
    
    func getCurrentDateAfterSwipe(swipeValue: CGSize) -> Date {
        let monthCount = (swipeValue.width > 0) ? -1 : 1

        var isNextButtonDisabled: Bool {
            guard let expectedDate = currentDate.date(byAddingMonth: 1)?.dateOnly else { return true }
            if let maxDate = maximumDate, expectedDate > maxDate {
                return true
            }
            return false
        }

        var isPreviousButtonDisabled: Bool {
            if appearance.allowPrecedeMinimumDate {
                return false
            }
            // -7 as max days from previous month can be 7.
            // current date is first of every month
            guard let expectedDate = currentDate.date(byAddingDays: -7)?.dateOnly else { return true }

            if let minDate = minimumDate, expectedDate < minDate {
                return true
            }
            return false
        }

        if (monthCount == -1 && isPreviousButtonDisabled) || (monthCount == 1 && isNextButtonDisabled) {
            return currentDate
        }

        return currentDate.date(byAddingMonth: monthCount)?.dateOnly ?? currentDate
    }
    
    func shouldEnableDate(_ date: Date, minimumDate: Date?, maximumDate: Date?) -> Bool {
        guard minimumDate != nil || maximumDate != nil else { return true }
        
        let date = date.dateOnly
        if let minimumDate = minimumDate {
            if date < minimumDate { return false }
        }
        
        if let maximumDate = maximumDate {
            if date > maximumDate { return false }
        }
        return true
    }

    func selectedDateDidChange(_ newValue: Date?) {
        delegate?.calendarViewDidSelectDate(newValue)
    }
    
    func monthDidChange(_ newValue: Date) {
        delegate?.calendarViewDidChangeMonth(to: newValue)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(
            minimumDate: Date().startDateOfMonth().date(byAddingMonth: -1),
            maximumDate: Date().startDateOfMonth().date(byAddingMonth: 2)
        )
        .padding(.horizontal, 16)
    }
}
