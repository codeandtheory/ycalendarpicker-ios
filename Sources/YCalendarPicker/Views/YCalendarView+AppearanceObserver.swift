//
//  YCalendarView+AppearanceObserver.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 29/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import Foundation

// Observe changes in appearance.
extension YCalendarView {
    class AppearanceObserver: ObservableObject {
        @Published var appearance: YCalendarPicker.Appearance
        
        /// Initializes an appearance (theme) observer.
        /// - Parameter appearance: appearance object
        init(appearance: YCalendarPicker.Appearance = .default) {
            self.appearance = appearance
        }
    }
}
