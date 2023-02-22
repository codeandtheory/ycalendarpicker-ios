//
//  String+toDate.swift
//  YCalendarPicker
//
//  Created by Sanjib Chakraborty on 20/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

public extension String {
    /// Creates a new Date from a string with string format.
    /// - Parameters:
    ///   - dateFormatType: The dateFormatType for conversion
    ///   - timeZone: Optional timeZone
    /// - Returns: A date representation of string. If unable to parse the string, returns nil.
    func toDate(
        withFormatType dateFormatType: DateFormatType,
        timeZone: TimeZone? = nil
    ) -> Date? {
        let dateFormatter = DateFormatterCache.current.cachedDateFormatter(
            format: dateFormatType.stringFormat,
            timeZone: timeZone
        )
        return dateFormatter.date(from: self)
    }
}
