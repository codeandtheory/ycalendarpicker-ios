//
//  CalendarPicker.swift
//  YCalendarPicker
//
//  Created by Sahil on 18/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import SwiftUI
import YCoreUI

/// UIKit month calendar picker
///
/// Renamed to `CalendarPicker`.
@available(*, deprecated, renamed: "CalendarPicker")
public typealias YCalendarPicker = CalendarPicker

/// CalendarPicker for use with UIKit
public class CalendarPicker: UIControl {
    var calendarView: CalendarView

    /// Delegate for month change
    weak public var delegate: CalendarPickerDelegate?
    
    /// Selected date (if any)
    public var date: Date? {
        get { calendarView.date }
        set { calendarView.date = newValue }
    }
    
    /// Calendar appearance
    public var appearance: Appearance {
        get { calendarView.appearance }
        set { calendarView.appearance = newValue }
    }
    
    /// Optional minimum date. Dates before the minimum cannot be selected. `nil` means no minimum (default).
    public var minimumDate: Date? {
        get { calendarView.minimumDate }
        set { calendarView.minimumDate = newValue }
    }
    /// Optional maximum date. Dates beyond the maximum cannot be selected. `nil` means no maximum (default).
    public var maximumDate: Date? {
        get { calendarView.maximumDate }
        set { calendarView.maximumDate = newValue }
    }

    /// Optional booked dates. These dates cannot be selected.
    public var bookedDates: [Date] {
        get { calendarView.bookedDates }
        set { calendarView.bookedDates = newValue }
    }
    
    /// Initializes a calendar picker control.
    /// - Parameters:
    ///   - firstWeekday: first weekday. Default is `nil` to use current calendar's value.
    ///   - appearance: appearance for the calendar. Default is `.default`.
    ///   - minimumDate: minimum selectable date. Default is `nil`.
    ///   - maximumDate: maximum selectable date. Default is `nil`.
    ///   - startDate: start date of the calendar. Default is `nil`.
    ///   - locale: locale for date formatting. Pass `nil` to use current locale. Default is `nil`.
    public required init(
        firstWeekday: Int? = nil,
        appearance: Appearance = .default,
        minimumDate: Date? = nil,
        maximumDate: Date? = nil,
        startDate: Date? = nil,
        locale: Locale? = nil
    ) {
        calendarView = CalendarView(
            firstWeekday: firstWeekday,
            appearance: appearance,
            minimumDate: minimumDate,
            maximumDate: maximumDate,
            startDate: startDate,
            locale: locale
        )
        super.init(frame: .zero)
        addCalendarView()
    }
    
    required init?(coder: NSCoder) {
        calendarView = CalendarView(
            firstWeekday: nil,
            appearance: Appearance(),
            minimumDate: nil,
            maximumDate: nil,
            startDate: nil,
            locale: nil
        )
        super.init(coder: coder)
        addCalendarView()
    }

    /// Calculates the intrinsic size of the calendar picker
    override public var intrinsicContentSize: CGSize {
        let monthLayout = appearance.monthStyle.typography.generateLayout(
            maximumScaleFactor: MonthView.maximumScaleFactor,
            compatibleWith: traitCollection
        )
        let weekdayLayout = appearance.weekdayStyle.typography.generateLayout(
            maximumScaleFactor: WeekdayView.maximumScaleFactor,
            compatibleWith: traitCollection
        )

        let daySize = DayView.size.outset(by: NSDirectionalEdgeInsets(all: DayView.padding))

        let width = 7 * daySize.width

        let monthHeight = max(monthLayout.lineHeight, MonthView.minimumButtonSize.height)
        let weekdayHeight = weekdayLayout.lineHeight + (2 * WeekdayView.verticalPadding)
        let daysHeight = 6 * daySize.height
        let height = monthHeight + weekdayHeight + daysHeight

        return CGSize(width: width, height: height)
    }

    /// Adjusts the intrinsic content size on Dynamic Type changes
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentFontAppearance(comparedTo: previousTraitCollection) {
            invalidateIntrinsicContentSize()
        }
    }
}

private extension CalendarPicker {
    func addCalendarView() {
        calendarView.delegate = self
        let hostController = UIHostingController(rootView: calendarView)
        addSubview(hostController.view)
        hostController.view.constrainEdges()
    }
}

extension CalendarPicker: CalendarViewDelegate {
    /// This method is used to inform when there is a change in selected date.
    /// - Parameter date: new selected date
    public func calendarViewDidSelectDate(_ date: Date?) {
        calendarView.date = date
        sendActions(for: .valueChanged)
    }
    /// This method is used to inform the change in month.
    /// - Parameter date: next/previous month(s) date
    public func calendarViewDidChangeMonth(to date: Date) {
        delegate?.calendarPicker(self, didChangeMonthTo: date)
    }
}
