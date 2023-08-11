//
//  CalendarPicker+Appearance..swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 28/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import UIKit
import YMatterType

/// Control theme i.e; color and typography
extension CalendarPicker {
    /// Appearance for CalendarPicker that contains typography and color properties
    public struct Appearance {
        /// Appearance for days within current month
        public var normalDayAppearance: Day
        /// Appearance for days outside current month
        public var grayedDayAppearance: Day
        /// Appearance for today
        public var todayAppearance: Day
        /// Appearance for selected day
        public var selectedDayAppearance: Day
        /// Appearance for disabled day
        public var disabledDayAppearance: Day
        /// Appearance for booked day
        public var bookedDayAppearance: Day
        /// Foreground color and typography for weekdays
        public var weekdayStyle: (textColor: UIColor, typography: Typography)
        /// Image for previous month button
        ///
        /// Images with template rendering mode will be tinted to `monthForegroundColor`.
        public var previousImage: UIImage?
        /// Image for next month button
        ///
        /// Images with template rendering mode will be tinted to `monthForegroundColor`.
        public var nextImage: UIImage?
        /// Foreground color and typography for month (and year)
        public var monthStyle: (textColor: UIColor, typography: Typography)
        /// Background color for calendar view
        public var backgroundColor: UIColor
        /// Enable preceding to minimum date.
        public var allowPrecedeMinimumDate: Bool

        /// Initializes a calendar appearance.
        /// - Parameters:
        ///   - normalDayAppearance: Appearance for days within current month. Default is `.Defaults.normal`.
        ///   - grayedDayAppearance: Appearance for days outside current month. Default is `.Defaults.grayed`.
        ///   - todayAppearance: Appearance for today. Default is `.Defaults.today`.
        ///   - selectedDayAppearance: Appearance for selected day. Default is `.Defaults.selected`.
        ///   - disabledDayAppearance: Appearance for disabled day. Default is `.Defaults.disabled`.
        ///   - bookedDayAppearance: Appearance for already booked day. Default is `Defaults.booked`.
        ///   - weekdayStyle: Typography and text color for weekday names. Default is `DefaultStyles.weekday`.
        ///   - previousImage: Previous button image. Default is `Appearance.defaultPreviousImage`.
        ///   - nextImage: Next button image. Default is `Appearance.defaultNextImage`.
        ///   - monthStyle: Typography and text color for Month name. Default is `DefaultStyles.month`.
        ///   - backgroundColor: Background color for calendar view. Default is `.systemBackground`.
        ///   - allowPrecedeMinimumDate: Enable preceding to minimum date. Default is `false`.

        public init(
            normalDayAppearance: Day = .Defaults.normal,
            grayedDayAppearance: Day = .Defaults.grayed,
            todayAppearance: Day = .Defaults.today,
            selectedDayAppearance: Day = .Defaults.selected,
            disabledDayAppearance: Day = .Defaults.disabled,
            bookedDayAppearance: Day = .Defaults.booked,
            weekdayStyle: (textColor: UIColor, typography: Typography) = DefaultStyles.weekday,
            previousImage: UIImage? = Appearance.defaultPreviousImage,
            nextImage: UIImage? = Appearance.defaultNextImage,
            monthStyle: (textColor: UIColor, typography: Typography) = DefaultStyles.month,
            backgroundColor: UIColor = .systemBackground,
            allowPrecedeMinimumDate: Bool = false
        ) {
            self.normalDayAppearance = normalDayAppearance
            self.grayedDayAppearance = grayedDayAppearance
            self.todayAppearance = todayAppearance
            self.selectedDayAppearance = selectedDayAppearance
            self.disabledDayAppearance = disabledDayAppearance
            self.bookedDayAppearance = bookedDayAppearance
            self.weekdayStyle = weekdayStyle
            self.previousImage = previousImage
            self.nextImage = nextImage
            self.monthStyle = monthStyle
            self.backgroundColor = backgroundColor
            self.allowPrecedeMinimumDate = allowPrecedeMinimumDate
        }
    }
}

extension CalendarPicker.Appearance {
    ///  Default Calendar appearance
    public static let `default` = CalendarPicker.Appearance()

    /// Default image for previous month button. Is a left chevron from SF Symbols in template rendering mode
    public static let defaultPreviousImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate)
    /// Default image for next month button. Is a right chevron from SF Symbols in template rendering mode
    public static let defaultNextImage = UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate)

    /// Default tint color for Calendar Picker (a purple color that adjusts for dark mode).
    ///
    /// By default used for month/year text, previous/next buttons, today appearance, and selected date appearance.
    public static let tintColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:    return UIColor(rgb: 0xEAE7FD)
        default:       return UIColor(rgb: 0x1B0B99)
        }
    }

    /// Foreground color to use against tint color
    public static let onTintColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:    return .black
        default:       return .white
        }
    }

    /// Background color to use for booked dates
    public static let bookedColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:    return UIColor(rgb: 0xBBB4F3)
        default:       return UIColor(rgb: 0x0B053F)
        }
    }

    /// Foreground color to use against booked color
    public static let onBookedColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch traitCollection.userInterfaceStyle {
        case .dark:    return .black
        default:       return .white
        }
    }

    /// A secondary label color that has .AA contrast vs `.systemBackground` in regular mode
    /// and .AAA contrast in high contrast mode
    public static let secondaryLabel = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch (traitCollection.userInterfaceStyle, traitCollection.accessibilityContrast) {
        case (.dark, .high):    return UIColor(rgb: 0x9B9B9B)
        case (_, .high):        return UIColor(rgb: 0x545454)
        default:                return UIColor(rgb: 0x757575)
        }
    }

    /// A quaternary label color that has 2.0 contrast vs `.systemBackground` in regular mode
    /// and 3.0 contrast in high contrast mode.
    ///
    /// Use it only for disabled elements that do not need to meet an WCAG contrast requirements.
    public static let quaternaryLabel = UIColor { (traitCollection: UITraitCollection) -> UIColor in
        switch (traitCollection.userInterfaceStyle, traitCollection.accessibilityContrast) {
        case (.dark, .high):    return UIColor(rgb: 0x5a5a5a)
        case (.dark, _):        return UIColor(rgb: 0x404040)
        case (_, .high):        return UIColor(rgb: 0x949494)
        default:                return UIColor(rgb: 0xB7B7B7)
        }
    }
}
