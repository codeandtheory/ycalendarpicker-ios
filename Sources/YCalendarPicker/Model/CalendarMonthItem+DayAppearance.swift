//
//  CalendarMonthItem+DayAppearance.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 09/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

extension CalendarMonthItem {
    func getDayAppearance(from appearance: CalendarPicker.Appearance) -> CalendarPicker.Appearance.Day {
        if isBooked {
            return appearance.bookedDayAppearance
        } else if !isEnabled {
            if isGrayedOut {
                return appearance.grayedDayAppearance
            }
            return appearance.disabledDayAppearance
        } else if isSelected {
            return appearance.selectedDayAppearance
        } else if isToday {
            return appearance.todayAppearance
        } else if isGrayedOut {
            return appearance.grayedDayAppearance
        }
        
        return appearance.normalDayAppearance
    }
}
