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
    /// maximum scale factor of the month-year text label
    static let maximumScaleFactor: CGFloat = 1.5
    /// size of each day
    static let size = CGSize(width: 40, height: 40)
    /// horizontal and vertical padding around day view circles
    static let padding: CGFloat = 2

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
                label.maximumScaleFactor = DayView.maximumScaleFactor
                label.textColor = appearance.foregroundColor
            })
            Spacer().frame(minWidth: DayView.size.width, minHeight: DayView.size.height)
        }
        .background(
            Circle()
                .stroke(Color(appearance.borderColor), lineWidth: appearance.borderWidth)
                .background(Circle().foregroundColor(Color(appearance.backgroundColor)))
        )
        .padding(.horizontal, DayView.padding)
        .padding(.vertical, DayView.padding)
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
