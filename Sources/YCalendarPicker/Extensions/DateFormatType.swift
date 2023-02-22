//
//  DateFormatType.swift
//  YCalendarPicker
//
//  Created by Sanjib Chakraborty on 22/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

/// The date format type used for string conversion.
public enum DateFormatType {
    /// The ISO8601 formatted year "yyyy" i.e. 2022
    case isoYear

    /// The ISO8601 formatted year and month "yyyy-MM" i.e. 2022-06
    case isoYearMonth

    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 2022-06-05
    case isoDate

    /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 2022-06-05T19:20:30+01:00
    case isoDateTime

    /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 2022-06-05T19:20:30.45+01:00
    case isoDateTimeFull

    /// The http header formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Sun, 5 Jun 2022 19:20:30 +0530"
    case httpHeader

    /// Last two digits of year, two-digit month, two-digit day
    case yyMMdd(separator: String)

    /// Two-digit month, two-digit day, last two digits of year
    case MMddyy(separator: String)

    /// Four-digit year, two-digit month, two-digit day
    case yyyyMMdd(separator: String)

    /// Two-digit day, two-digit month, four-digit year
    case ddMMyyyy(separator: String)

    /// Two-digit month, two-digit day, four-digit year
    case MMddyyyy(separator: String)

    /// Two-digit day, two-digit month, last two digits of year
    case ddMMyy(separator: String)

    /// Last two digits of year, three-letter abbreviation of the month, two-digit day
    case yyMMMdd(separator: String)

    /// Two-digit day, three-letter abbreviation of the month, last two digits of year
    case ddMMMyy(separator: String)

    /// Three-letter abbreviation of the month, two-digit day, last two digits of year
    case MMMddyy(separator: String)

    /// Four-digit year, Three-letter abbreviation of the month, two-digit day
    case yyyyMMMdd(separator: String)

    /// Two-digit day, Three-letter abbreviation of the month, Four-digit year
    case ddMMMyyyy(separator: String)

    /// Three-letter abbreviation of the month, two-digit day, four-digit year
    case MMMddyyyy(separator: String)

    /// Last two digits of year, Three-digit Julian day
    case yyDDD(separator: String)

    /// Three-digit Julian day, last two digits of year
    case DDDyy(separator: String)

    /// Four-digits year, Three-digit Julian day
    case yyyyDDD(separator: String)

    /// Three-digit Julian day, Four digits of year
    case DDDyyyy(separator: String)

    /// Four-digits of year, Two-digit month
    case yyyyMM(separator: String)

    /// Full name of the Month (example: December)
    case MMMM

    /// Full name of the day (example: Sunday)
    case EEEE

    /// Four-digit year
    case yyyy

    /// Two-digit hour, two-digit minutes
    case HHmm(separator: String)

    /// Two-digit hour, two-digit minutes, two-digit seconds
    case HHmmss(separator: String)

    /// Four-digits year, two-digits month, two-digits day, zulu time indicator
    case yyyyMMddZ

    /// A custom date format string. In case of separator replacement,
    /// use '_' in the format string and this will be replaced with supplied separator.
    case custom(format: String, separator: String? = nil)
}

extension DateFormatType {
    var stringFormat: String {
        switch self {
        case .isoYear: return "yyyy"

        case .isoYearMonth: return "yyyy-MM"

        case .isoDate: return "yyyy-MM-dd"

        case .isoDateTime: return "yyyy-MM-dd'T'HH:mm:ssZ"

        case .isoDateTimeFull: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        case .httpHeader: return "EEE, d MMM yyyy HH:mm:ss ZZZ"

        case .yyMMdd(let separator):
            return "yy_MM_dd".replacingOccurrences(of: "_", with: separator)

        case .MMddyy(let separator):
            return "MM_dd_yy".replacingOccurrences(of: "_", with: separator)

        case .yyyyMMdd(let separator):
            return "yyyy_MM_dd".replacingOccurrences(of: "_", with: separator)

        case .ddMMyyyy(let separator):
            return "dd_MM_yyyy".replacingOccurrences(of: "_", with: separator)

        case .MMddyyyy(let separator):
            return "MM_dd_yyyy".replacingOccurrences(of: "_", with: separator)

        case .ddMMyy(let separator):
            return "dd_MM_yy".replacingOccurrences(of: "_", with: separator)

        case .yyMMMdd(let separator):
            return "yy_MMM_dd".replacingOccurrences(of: "_", with: separator)

        case .ddMMMyy(separator: let separator):
            return "dd_MMM_yy".replacingOccurrences(of: "_", with: separator)

        case .MMMddyy(separator: let separator):
            return "MMM_dd_yy".replacingOccurrences(of: "_", with: separator)

        case .yyyyMMMdd(separator: let separator):
            return "yyyy_MMM_dd".replacingOccurrences(of: "_", with: separator)

        case .ddMMMyyyy(separator: let separator):
            return "dd_MMM_yyyy".replacingOccurrences(of: "_", with: separator)

        case .MMMddyyyy(separator: let separator):
            return "MMM_dd_yyyy".replacingOccurrences(of: "_", with: separator)

        case .yyDDD(separator: let separator):
            return "yy_DDD".replacingOccurrences(of: "_", with: separator)

        case .DDDyy(separator: let separator):
            return "DDD_yy".replacingOccurrences(of: "_", with: separator)

        case .yyyyDDD(separator: let separator):
            return "yyyy_DDD".replacingOccurrences(of: "_", with: separator)

        case .DDDyyyy(separator: let separator):
            return "DDD_yyyy".replacingOccurrences(of: "_", with: separator)

        case .yyyyMM(separator: let separator):
            return "yyyy_MM".replacingOccurrences(of: "_", with: separator)

        case .MMMM: return "MMMM"

        case .EEEE: return "EEEE"

        case .yyyy: return "yyyy"

        case .HHmm(separator: let separator):
            return "HH_mm".replacingOccurrences(of: "_", with: separator)

        case .HHmmss(separator: let separator):
            return "HH_mm_ss".replacingOccurrences(of: "_", with: separator)

        case .yyyyMMddZ:
            return "yyyyMMddZ"

        case .custom(let format, let separator):
            if let separator = separator,
               !separator.isEmpty {
                return format.replacingOccurrences(of: "_", with: separator)
            } else {
                return format
            }
        }
    }
}
