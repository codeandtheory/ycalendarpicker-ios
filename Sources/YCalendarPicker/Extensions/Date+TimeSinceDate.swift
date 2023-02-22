//
//  Date+TimeSinceDate.swift
//
//  Created by Visakh Tharakan on 30/06/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

/// A date extension with helper function to get the time elapsed from a given point of time
public extension Date {
    private static let relativeFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()

    /// Returns the time elapsed in `String` from the given date to the relative date.
    /// - Parameter date: Reference date to calculate elapsed time. Default is `Date()`.
    /// - Returns: Time elapsed in `String`.
    func timeElapsed(relativeTo date: Date = Date()) -> String {
        Date.relativeFormatter.localizedString(for: self, relativeTo: date)
    }
}
