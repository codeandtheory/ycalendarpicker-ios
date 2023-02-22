//
//  DayView.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 02/12/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import SwiftUI
import YMatterType

struct DayView {
    let appearance: YCalendarPicker.Appearance
    let dateItem: CalendarMonthItem
    let locale: Locale
    @Binding var selectedDate: Date?
}

extension DayView: View {
    var body: some View {
        let appearance = getDayAppearance()
        getDayView(appearance: appearance)
    }
    
    func getDayView(appearance: YCalendarPicker.Appearance.Day) -> some View {
        ZStack {
            TextStyleLabel(dateItem.day, typography: appearance.typography, configuration: { label in
                label.isUserInteractionEnabled = true
                label.textAlignment = .center
                label.maximumScaleFactor = 1.5
                label.textColor = appearance.foregroundColor
            })
            Spacer().frame(minWidth: 40, minHeight: 40)
        }
        .background(
            Circle()
                .stroke(Color(appearance.borderColor), lineWidth: appearance.borderWidth)
                .background(Circle().foregroundColor(Color(appearance.backgroundColor)))
        )
        .padding(.horizontal, 2.0)
        .padding(.vertical, 2.0)
        .onTapGesture {
            guard dateItem.isEnabled else { return }
            selectedDate = dateItem.date
        }
        .accessibilityAddTraits(getAccessibilityTraits())
        .accessibilityLabel(getAccessibilityText())
        .accessibilityHint(getAccessibilityHint())
        .disabled(!dateItem.isSelectable)
    }
    
    func getAccessibilityText() -> String {
        var accessibilityText = dateItem.date.toString(withTemplate: "dEEEEMMMM", locale: locale) ?? ""

        if dateItem.isToday {
            accessibilityText.append(YCalendarPicker.Strings.todayDayDescriptor.localized)
        }
        
        if dateItem.isBooked {
            accessibilityText.append(YCalendarPicker.Strings.bookedDayDescriptor.localized)
        }
        
        return accessibilityText
    }

    func getAccessibilityTraits() -> AccessibilityTraits {
        if dateItem.isSelected {
            return .isSelected
        }

        return .isButton
    }

    func getAccessibilityHint() -> String {
        guard dateItem.isSelectable,
              !dateItem.isSelected else { return "" }
        
        return YCalendarPicker.Strings.dayButtonA11yHint.localized
    }

    func getDayAppearance() -> YCalendarPicker.Appearance.Day {
        dateItem.getDayAppearance(from: appearance)
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        let locale = Locale(identifier: "de_DE")
        let today = Date().dateOnly
        let yesterday = today.previousDate()
        let earlier = yesterday.previousDate()
        let tomorrow = today.nextDate()
        let dayAfter = tomorrow.nextDate()
        let later = dayAfter.nextDate()

        let item1 = earlier.toCalendarItem(isGrayedOut: true)
        let item2 = yesterday.toCalendarItem()
        let item3 = today.toCalendarItem()
        let item4 = tomorrow.toCalendarItem(isSelected: true)
        let item5 = dayAfter.toCalendarItem(isBooked: true)
        let item6 = later.toCalendarItem(isEnabled: false)
        HStack {
            DayView(appearance: .default, dateItem: item1, locale: locale, selectedDate: .constant(Date()))
            DayView(appearance: .default, dateItem: item2, locale: locale, selectedDate: .constant(Date()))
            DayView(appearance: .default, dateItem: item3, locale: locale, selectedDate: .constant(Date()))
            DayView(appearance: .default, dateItem: item4, locale: locale, selectedDate: .constant(Date()))
            DayView(appearance: .default, dateItem: item5, locale: locale, selectedDate: .constant(Date()))
            DayView(appearance: .default, dateItem: item6, locale: locale, selectedDate: .constant(Date()))
        }
        .padding(.horizontal, 16)
    }
}
