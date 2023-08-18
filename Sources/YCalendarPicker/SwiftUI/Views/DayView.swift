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

    let appearance: CalendarPicker.Appearance.Day
    let dateItem: CalendarMonthItem
    let locale: Locale
    @Binding var selectedDate: Date?
}

extension DayView: View {
    var body: some View {
        getDayView()
    }
    
    func getDayView() -> some View {
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
            guard !appearance.isHidden else { return }
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
            accessibilityText.append(CalendarPicker.Strings.todayDayDescriptor.localized)
        }
        
        if dateItem.isBooked {
            accessibilityText.append(CalendarPicker.Strings.bookedDayDescriptor.localized)
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
        
        return CalendarPicker.Strings.dayButtonA11yHint.localized
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
        let appearance = CalendarPicker.Appearance()
        HStack {
            DayView(
                appearance: appearance.grayedDayAppearance,
                dateItem: item1,
                locale: locale,
                selectedDate: .constant(Date())
            )
            DayView(
                appearance: appearance.normalDayAppearance,
                dateItem: item2,
                locale: locale,
                selectedDate: .constant(Date())
            )
            DayView(
                appearance: appearance.todayAppearance,
                dateItem: item3,
                locale: locale,
                selectedDate: .constant(Date())
            )
            DayView(
                appearance: appearance.selectedDayAppearance,
                dateItem: item4,
                locale: locale,
                selectedDate: .constant(Date())
            )
            DayView(
                appearance: appearance.bookedDayAppearance,
                dateItem: item5,
                locale: locale,
                selectedDate: .constant(Date())
            )
            DayView(
                appearance: appearance.disabledDayAppearance,
                dateItem: item6,
                locale: locale,
                selectedDate: .constant(Date())
            )
        }
        .padding(.horizontal, 16)
    }
}
