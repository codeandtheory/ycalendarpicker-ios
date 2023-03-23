//
//  CalendarPicker+Appearance+Day.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 14/12/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YMatterType

extension CalendarPicker.Appearance {
    /// Appearance for Date
    public struct Day {
        /// Typography for day view
        public var typography: Typography
        /// Foreground color for day view
        public var foregroundColor: UIColor
        /// Background color for day view
        public var backgroundColor: UIColor
        /// Border color for day view
        public var borderColor: UIColor
        /// Border width for day view
        public var borderWidth: CGFloat
        
        /// Initializes a calendar day appearance
        /// - Parameters:
        ///   - typography: Typography for day view. Default is `Typography.day`.
        ///   - foregroundColor: Foreground color for day view. Default is `.label`.
        ///   - backgroundColor: Background color for day view. Default is `.clear`.
        ///   - borderColor: Border color for day view. Default is `.clear`.
        ///   - borderWidth: Border width for day view. Default is `1.0`.
        public init(
            typography: Typography = .day,
            foregroundColor: UIColor = .label,
            backgroundColor: UIColor = .clear,
            borderColor: UIColor = .clear,
            borderWidth: CGFloat = 1.0
        ) {
            self.typography = typography
            self.foregroundColor = foregroundColor
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
        }
    }
}

extension CalendarPicker.Appearance.Day {
    ///  Default Day appearances
    public enum Defaults {
        /// Default appearance for days within the current month
        public static let normal = CalendarPicker.Appearance.Day()
        /// Default appearance for days outside of the current month
        public static let grayed = CalendarPicker.Appearance.Day(
            foregroundColor: CalendarPicker.Appearance.secondaryLabel
        )
        /// Default appearance for days outside enabled range
        public static let disabled = CalendarPicker.Appearance.Day(
            foregroundColor: CalendarPicker.Appearance.quaternaryLabel
        )
        /// Default appearance for already booked day
        public static let booked = CalendarPicker.Appearance.Day(
            foregroundColor: CalendarPicker.Appearance.onBookedColor,
            backgroundColor: CalendarPicker.Appearance.bookedColor
        )
        /// Default appearance for today (unless selected)
        public static let today = CalendarPicker.Appearance.Day(
            foregroundColor: CalendarPicker.Appearance.tintColor,
            borderColor: CalendarPicker.Appearance.tintColor
        )
        /// Default appearance for currently selected day
        public static let selected = CalendarPicker.Appearance.Day(
            foregroundColor: CalendarPicker.Appearance.onTintColor,
            backgroundColor: CalendarPicker.Appearance.tintColor
        )
    }
}
