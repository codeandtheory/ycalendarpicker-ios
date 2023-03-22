//
//  Typography+CalendarPicker.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 07/02/23.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation
import YMatterType

/// Default typographies for the Month Calendar Picker
public extension Typography {
    /// Month-year, regular 22/28
    static let month = Typography(
        fontFamily: Typography.systemFamily,
        fontWeight: .regular,
        fontSize: 22,
        lineHeight: 28,
        textStyle: .title2
    )
   
    /// Weekday, regular 16/20 pts
    static let weekday = Typography(
        fontFamily: Typography.systemFamily,
        fontWeight: .regular,
        fontSize: 16,
        lineHeight: 20,
        textStyle: .callout
    )
    
    /// Day, regular 17/22 pts
    static let day = Typography(
        fontFamily: Typography.systemFamily,
        fontWeight: .regular,
        fontSize: 17,
        lineHeight: 22,
        textStyle: .body
    )
}
