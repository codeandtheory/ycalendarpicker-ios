//
//  CalendarPickerTests.swift
//  YCalendarPicker
//
//  Created by YML on 16/11/22.
//  Copyright © 2023 Y Media Labs. All rights reserved.
//

import XCTest
@testable import YCalendarPicker

final class CalendarPickerTests: XCTestCase {
    func testCalendarPickerIsNotNil() {
        let sut = makeSUT()
        XCTAssertNotNil(sut)
    }
    
    func testCalendarViewIsNotNil() {
        let sut = makeSUT()
        sut.appearance = .default
        XCTAssertNotNil(sut.calendarView)
    }

    func testCalendarViewAppearanceSetCorrectly() {
        let sut = makeSUT()
        sut.appearance = CalendarPicker.Appearance(weekdayStyle: (textColor: .red, typography: .weekday))
        XCTAssertEqual(UIColor.red, sut.appearance.weekdayStyle.textColor)
    }
    
    func testCalendarViewMinDateSetCorrectly() {
        let sut = makeSUT()
        let minDate = Date().previousDate()
        sut.minimumDate = minDate
        XCTAssertEqual(sut.minimumDate, minDate.dateOnly)
    }
    
    func testCalendarViewMaxDateSetCorrectly() {
        let sut = makeSUT()
        let maxDate = Date().previousDate()
        sut.maximumDate = maxDate
        XCTAssertEqual(sut.maximumDate, maxDate.dateOnly)
    }
    
    func testCalendarPickerMaxMinDateSetCorrectly() {
        let maxDate = Date()
        let minDate = Date().previousDate()
        let sut = makeSUT(maxDate: maxDate, minDate: minDate)
        XCTAssertEqual(sut.calendarView.minimumDate, minDate.dateOnly)
        XCTAssertEqual(sut.calendarView.maximumDate, maxDate.dateOnly)
    }
    
    func testCalendarPickerBookedDatesSetCorrectly() {
        let bookedDates = [Date().dateOnly, Date().previousDate().dateOnly]
        let sut = makeSUT()
        sut.bookedDates = bookedDates
        XCTAssertEqual(sut.bookedDates, bookedDates)
        XCTAssertEqual(sut.calendarView.bookedDates, bookedDates)
    }
    
    func testSelectedDate() throws {
        let sut = makeSUT()
        XCTAssertNil(sut.date)
        let selectedDate = try XCTUnwrap(Date().date(byAddingMonth: 1))
        sut.date = selectedDate
        XCTAssertEqual(sut.date, selectedDate.dateOnly)
    }

    func testCalendarPickerPrecedeMinDate() throws {
        let minDate = Date().previousDate()
        let sut = makeSUT(minDate: minDate)

        var monthView = try XCTUnwrap(sut.calendarView.getMonthView() as? MonthView)

        XCTAssertTrue(monthView.isPreviousButtonDisabled)

        XCTAssertEqual(
            sut.calendarView.currentDate,
            sut.calendarView.getCurrentDateAfterSwipe(
                swipeValue: CGSize(width: 10, height: 10)
            )
        )

        sut.appearance.allowPrecedeMinimumDate = true
        monthView = try XCTUnwrap(sut.calendarView.getMonthView() as? MonthView)
        XCTAssertFalse(monthView.isPreviousButtonDisabled)

        XCTAssertNotEqual(
            sut.calendarView.currentDate,
            sut.calendarView.getCurrentDateAfterSwipe(
                swipeValue: CGSize(width: 10, height: 10)
            )
        )
    }

    func testCalendarPickerIsNotNilForOptionalInit() {
        XCTAssertNotNil(makeSUTWithFailable())
    }

    func testCalendarPickerUpdatesDate() throws {
        let sut = makeSUT()
        XCTAssertNil(sut.date)

        let newDate = try XCTUnwrap(Date().date(byAddingMonth: 1))

        sut.calendarView.selectedDateDidChange(newDate)
        XCTAssertEqual(sut.date, newDate.dateOnly)

        sut.calendarView.selectedDateDidChange(nil)
        XCTAssertNil(sut.date)
    }

    func testCalendarPickerUpdatesDateOnlyFromOwnCalendarView() throws {
        let sut = makeSUT()
        let sut2 = makeSUT()
        XCTAssertNil(sut.date)
        XCTAssertNil(sut2.date)

        let date1 = try XCTUnwrap(Date().date(byAddingMonth: 1)?.dateOnly)
        let date2 = try XCTUnwrap(Date().date(byAddingMonth: -1)?.dateOnly)

        sut2.calendarView.selectedDateDidChange(date2)
        XCTAssertNil(sut.date)
        XCTAssertEqual(sut2.date, date2)

        sut.calendarView.selectedDateDidChange(date1)
        XCTAssertEqual(sut.date, date1)
        XCTAssertEqual(sut2.date, date2)
        
        sut.calendarView.monthDidChange(date2)
        XCTAssertNotEqual(sut.calendarView.currentDate, date2)
        
        sut2.calendarView.monthDidChange(date1)
        XCTAssertNotEqual(sut.calendarView.currentDate, date2)
    }

    func testIntrinsicContentSize() {
        let sut = makeSUT()

        let size = sut.intrinsicContentSize
        let daySize = DayView.size.outset(by: NSDirectionalEdgeInsets(all: DayView.padding))
        let monthHeight = MonthView.minimumButtonSize.height
        let weekdayHeight = sut.appearance.weekdayStyle.typography.lineHeight + 2 * WeekdayView.verticalPadding
        let daysHeight = 6 * daySize.height

        XCTAssertEqual(size.width, 7 * daySize.width)
        XCTAssertEqual(size.height, monthHeight + weekdayHeight + daysHeight)
    }

    func testRespondsToDynamicTypeChanges() {
        let sut = makeSUT()

        let oldSize = sut.intrinsicContentSize

        // create some nested view controllers so that we can override traits
        let (parent, child) = makeNestedViewControllers(subview: sut)

        let traits = UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge) // really large
        parent.setOverrideTraitCollection(traits, forChild: child)
        sut.traitCollectionDidChange(traits)
        
        let newSize = sut.intrinsicContentSize

        XCTAssertEqual(newSize.width, oldSize.width)
        XCTAssertGreaterThan(newSize.height, oldSize.height)
    }
}

private extension CalendarPickerTests {
    func makeSUT(
        firstWeekday: Int? = nil,
        maxDate: Date? = nil,
        minDate: Date? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> CalendarPicker {
        let sut = CalendarPicker(minimumDate: minDate, maximumDate: maxDate)
        trackForMemoryLeak(sut, file: file, line: line)
        return sut
    }
    
    func makeSUTWithFailable(
        firstWeekday: Int? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> CalendarPicker? {
        let sut = CalendarPicker()
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: sut, requiringSecureCoding: false) else {
            return nil
        }
        guard let coder = try? NSKeyedUnarchiver(forReadingFrom: data) else { return nil }
        trackForMemoryLeak(sut, file: file, line: line)
        return CalendarPicker(coder: coder)
    }

    /// Create nested view controllers containing the view to be tested so that we can override traits
    func makeNestedViewControllers(
        subview: UIView,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (parent: UIViewController, child: UIViewController) {
        let parent = UIViewController()
        let child = UIViewController()
        parent.addChild(child)
        parent.view.addSubview(child.view)

        // constrain child controller view to parent
        child.view.constrainEdges()

        child.view.addSubview(subview)

        // constrain subview to child view center
        subview.constrainCenter()

        trackForMemoryLeak(parent, file: file, line: line)
        trackForMemoryLeak(child, file: file, line: line)

        return (parent, child)
    }
}
