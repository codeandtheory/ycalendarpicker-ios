//
//  CalendarPicker+Appearance+Style.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 09/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import YMatterType
import UIKit

extension CalendarPicker.Appearance {
    /// Appearance for weekday, month
    public enum DefaultStyles {
        /// Default value for weekday
        public static let weekday: (textColor: UIColor, typography: Typography) = (
            CalendarPicker.Appearance.secondaryLabel, .weekday
        )
        /// Default value for month
        public static let month: (textColor: UIColor, typography: Typography) = (
            CalendarPicker.Appearance.tintColor, .month
        )
    }
}
