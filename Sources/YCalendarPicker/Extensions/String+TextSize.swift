//
//  String+TextSize.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 05/12/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.

import SwiftUI

extension String {
    func size(of font: UIFont) -> CGSize {
        self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
}
