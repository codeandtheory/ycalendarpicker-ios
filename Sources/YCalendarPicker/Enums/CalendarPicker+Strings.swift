//
//  CalendarPicker+Strings.swift
//  YCalendarPicker
//
//  Created by Mark Pospesel on 1/13/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import YCoreUI

extension CalendarPicker {
    enum Strings: String, Localizable, CaseIterable {
        case previousMonthA11yLabel = "Previous_Month_Button_A11y_Label"
        case nextMonthA11yLabel = "Next_Month_Button_A11y_Label"
        case dayButtonA11yHint = "Day_Button_A11y_Hint"
        case todayDayDescriptor = "Today_Day_Descriptor"
        case bookedDayDescriptor = "Booked_Day_Descriptor"

        static var bundle: Bundle { .module }
    }
}
