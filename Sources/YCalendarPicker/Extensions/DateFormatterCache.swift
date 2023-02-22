//
//  DateFormatterCache.swift
//  YCalendarPicker
//
//  Created by Sanjib Chakraborty on 06/07/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

/// Date formatter cache
final class DateFormatterCache {
    /// Singleton object for date formatter cache
    static let current = DateFormatterCache()

    /// Cached date format in a dictionary using key.
    /// The key is combination of hash value of format, timeZone and locale.
    internal var cachedDateFormatters = [String: DateFormatter]()

    /// Save a date formatter into the cache
    /// - Parameters:
    ///   - dateFormatter: Date formatter to save into the cache
    ///   - key: Key used to save the formatter
    private func register(dateFormatter: DateFormatter, key: String) {
        cachedDateFormatters[key] = dateFormatter
    }

    /// Retrieve a date formatter from cache
    /// - Parameter key: Formatter key used for saving into the cache
    /// - Returns: A cached date formatter
    private func retrieveDateFormatter(for key: String) -> DateFormatter? {
        cachedDateFormatters[key]
    }

    /// Create or retrieve a cached formatter based on the provided format. Formatters are cached in a dictionary.
    /// - Parameters:
    ///   - format: The format for which we want
    ///   - timeZone: The time zone to use. Pass `nil` (default) to use the current time zone.
    /// - Returns: a dateFormatter that is newly created or retrieve if cached
    func cachedDateFormatter(
        format: String,
        timeZone: TimeZone? = nil
    ) -> DateFormatter {
        let formatterKey = "\(format)\(timeZone?.hashValue ?? 0)"
        if let formatter = retrieveDateFormatter(for: formatterKey) {
            return formatter
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        register(dateFormatter: formatter, key: formatterKey)
        return formatter
    }

    /// Create or retrieve a cached formatter based on the provided template. Formatters are cached in a dictionary.
    /// - Parameters:
    ///   - template: The template string
    ///   - locale: The locale to use. Pass `nil` (default) to use the current locale.
    /// - Returns: a dateFormatter that is newly created or retrieve if cached
    func cachedTemplateDateFormatter(template: String, locale: Locale? = nil) -> DateFormatter {
        let locale = locale ?? .current
        let formatterKey = "template\(template)\(locale.identifier)"
        if let formatter = retrieveDateFormatter(for: formatterKey) {
            return formatter
        }

        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.setLocalizedDateFormatFromTemplate(template)
        register(dateFormatter: formatter, key: formatterKey)
        return formatter
    }
}
