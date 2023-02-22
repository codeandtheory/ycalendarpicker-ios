//
//  WeekdayView.swift
//  YCalendarPicker
//
//  Created by Sahil on 14/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import SwiftUI
import YMatterType

/// WeekdayView is the view shown for weekday names at top of days/dates
internal struct WeekdayView {
    var firstWeekday = 0
    var appearance: YCalendarPicker.Appearance
    let weekdayNames: [String]
    
    let locale: Locale
    
    init(firstWeekday: Int = 0, appearance: YCalendarPicker.Appearance, locale: Locale) {
        self.firstWeekday = firstWeekday
        self.appearance = appearance
        self.locale = locale
        
        let dateFormetter = DateFormatter()
        dateFormetter.locale = locale
        
        weekdayNames = dateFormetter.shortWeekdaySymbols ?? ["🚨", "E", "R", "R", "O", "R", "!"]
    }
}

extension WeekdayView: View {
    var body: some View {
        getWeekdayView()
            .accessibilityHidden(true)
    }
    
    @ViewBuilder
    func getWeekdayView() -> some View {
        LazyVGrid(columns: Constants.columns, spacing: 0) {
            ForEach(firstWeekday...6 + firstWeekday, id: \.self) { index in
                getWeekText(for: index.modulo(7))
            }
        }
        .padding(.vertical, 2)
    }
    
    @ViewBuilder
    func getWeekText(for index: Int) -> some View {
        TextStyleLabel(weekdayNames[index], typography: appearance.weekdayStyle.typography, configuration: { label in
            label.textAlignment = .center
            label.maximumScaleFactor = 1.33
            label.textColor = appearance.weekdayStyle.textColor
        })
    }
}

struct WeekdayView_Previews: PreviewProvider {
    static var previews: some View {
        WeekdayView(firstWeekday: 0, appearance: .default, locale: .current)
        .padding(.horizontal, 16)
    }
}
