//
//  DaysView.swift
//  YCalendarPicker
//
//  Created by Sahil on 14/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import SwiftUI

/// DaysView is the view shown for dates
internal struct DaysView {
    var allDates: [CalendarMonthItem]
    var appearance: CalendarPicker.Appearance
    @Binding var selectedDate: Date?
    let locale: Locale
}

extension DaysView: View {
    var body: some View {
        getDaysView()
    }
    
    @ViewBuilder
    func getDaysView() -> some View {
        LazyVGrid(columns: Constants.columns, spacing: 0) {
            ForEach(0..<allDates.count, id: \.self) { index in
                getDay(index: index)
            }
        }
    }
    
    func getDay(index: Int) -> some View {
        var dateItem = allDates[index]
        dateItem.isSelected = dateItem.date == selectedDate
        let dayView = DayView(
            appearance: appearance,
            dateItem: dateItem,
            locale: locale,
            selectedDate: $selectedDate
        )
        return dayView
    }
}

struct DaysView_Previews: PreviewProvider {
    static var previews: some View {
        DaysView(
            allDates: Date().getAllDatesForSelectedMonth(firstWeekIndex: 0),
            appearance: .default,
            selectedDate: .constant(Date()),
            locale: Locale(identifier: "de_DE")
        )
        .padding(.horizontal, 16)
    }
}
