//
//  Date+toString.swift
//  YCalendarPicker
//
//  Created by Sanjib Chakraborty on 20/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

public extension Date {
    /// Converts the date to string based on a date format
    /// - Parameters:
    ///   - dateFormatType: The dateFormatType for conversion
    ///   - timeZone: Optional timeZone
    /// - Returns: The string representation of date
    func toString(
        withFormatType dateFormatType: DateFormatType,
        timeZone: TimeZone? = nil
    ) -> String? {
        let dateFormatter = DateFormatterCache.current.cachedDateFormatter(
            format: dateFormatType.stringFormat,
            timeZone: timeZone
        )
        return dateFormatter.string(from: self)
    }

    /// Converts the date to string based on a provided template
    /// - Parameters:
    ///   - template: The template string
    ///   - locale: The locale to use. Pass `nil` (default) to use the current locale.
    /// - Returns: The localized string representation of the date
    func toString(withTemplate template: String, locale: Locale? = nil) -> String? {
        let dateFormatter = DateFormatterCache.current.cachedTemplateDateFormatter(template: template, locale: locale)
        return dateFormatter.string(from: self)
    }
}
