//
//  MonthView.swift
//  YCalendarPicker
//
//  Created by Sahil Saini on 29/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import SwiftUI
import YMatterType

/// Displays current month and year together with previous and next buttons
internal struct MonthView {
    /// maximum scale factor of the month-year text label
    static let maximumScaleFactor: CGFloat = 1.5
    /// minimum size for previous and next buttons
    static let minimumButtonSize = CGSize(width: 44, height: 44)

    @Binding var currentDate: Date
    var appearance: CalendarPicker.Appearance
    let dateFormat: String
    let minimumDate: Date?
    let maximumDate: Date?
    let locale: Locale
    
    var isNextButtonDisabled: Bool {
        guard let expectedDate = currentDate.date(byAddingMonth: 1)?.dateOnly else { return true }
        if let maxDate = maximumDate, expectedDate > maxDate {
            return true
        }
        return false
    }
    
    var isPreviousButtonDisabled: Bool {
        if appearance.allowPrecedeMinimumDate {
            return false
        }
        // -7 as max days from previous month can be 7.
        // current date is first of every month
        guard let expectedDate = currentDate.date(byAddingDays: -7)?.dateOnly else { return true }
        
        if let minDate = minimumDate, expectedDate < minDate {
            return true
        }
        return false
    }
}

extension MonthView: View {
    var body: some View {
        getMonthView()
    }
    
    @ViewBuilder
    func getMonthView() -> some View {
        HStack {
            TextStyleLabel(getMonthAndYear(), typography: appearance.monthStyle.typography, configuration: { label in
                label.textColor = appearance.monthStyle.textColor
                label.maximumScaleFactor = MonthView.maximumScaleFactor
            })
            
            Spacer()
            
            HStack(spacing: 0) {
                Button(action: {
                    updateCurrentDate(byAddingMonth: -1)
                }, label: {
                    getPreviousImage()
                        .foregroundColor(Color(appearance.monthStyle.textColor))
                        .opacity(isPreviousButtonDisabled ? 0.5 : 1.0)
                })
                .frame(
                    minWidth: MonthView.minimumButtonSize.width,
                    minHeight: MonthView.minimumButtonSize.height
                )
                .disabled(isPreviousButtonDisabled)
                .accessibilityLabel(CalendarPicker.Strings.previousMonthA11yLabel.localized)
                Button(action: {
                    updateCurrentDate(byAddingMonth: 1)
                }, label: {
                    getNextImage()
                        .foregroundColor(Color(appearance.monthStyle.textColor))
                        .opacity(isNextButtonDisabled ? 0.5 : 1.0)
                })
                .frame(
                    minWidth: MonthView.minimumButtonSize.width,
                    minHeight: MonthView.minimumButtonSize.height
                )
                .disabled(isNextButtonDisabled)
                .accessibilityLabel(CalendarPicker.Strings.nextMonthA11yLabel.localized)
            }
        }
    }
    
    func updateCurrentDate(byAddingMonth count: Int) {
        guard let newValue = currentDate.date(byAddingMonth: count)?.dateOnly else { return }
        currentDate = newValue
    }
    
    func getPreviousImage() -> Image {
        guard let image = appearance.previousImage else {
            return Image(systemName: "chevron.left").renderingMode(.template)
        }
        return Image(uiImage: image)
    }
    
    func getNextImage() -> Image {
        guard let image = appearance.nextImage else {
            return Image(systemName: "chevron.right").renderingMode(.template)
        }
        return Image(uiImage: image)
    }
    
    func getMonthAndYear() -> String {
        currentDate.toString(withTemplate: dateFormat, locale: locale) ?? ""
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(
            currentDate: .constant(Date()),
            appearance: .default,
            dateFormat: "MMMMyyyy",
            minimumDate: nil,
            maximumDate: nil,
            locale: Locale(identifier: "pt_BR")
        )
        .padding(.horizontal, 16)
    }
}
