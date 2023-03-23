//
//  CalendarView+DateObserver.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 06/01/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

// Observe key dates.
extension CalendarView {
    class DateObserver: ObservableObject {
        @Published var minimumDate: Date?
        @Published var maximumDate: Date?
        @Published var bookedDates: [Date]
        @Published var date: Date?
        
        /// Initializes a date observer for dates that would change `CalendarView`'s appearance.
        /// - Parameters:
        ///   - minimumDate: minimum date to enable
        ///   - maximumDate: maximum date to enable
        ///   - bookedDates: array of laready booked dates
        ///   - date: selected date (if any)
        init(minimumDate: Date? = nil, maximumDate: Date? = nil, bookedDates: [Date] = [], date: Date? = nil) {
            self.minimumDate = minimumDate
            self.maximumDate = maximumDate
            self.bookedDates = bookedDates
            self.date = date
        }
    }
}
