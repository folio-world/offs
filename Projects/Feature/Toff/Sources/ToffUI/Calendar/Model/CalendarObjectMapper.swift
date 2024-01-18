//
//  CalendarObjectMapper.swift
//  ToffFeature
//
//  Created by 송영모 on 1/8/24.
//

import Foundation
import Domain

public struct CalendarObjectMapper {
    public static func calendarTabItem(
        id: UUID = .init(),
        date: Date,
        selectedDate: Date,
        trades: [Trade]
    ) -> CalendarTabItem {
        return .init(
            id: id,
            date: date,
            cells: .init(uniqueElements: calendarCellItems(date: date, selectedDate: selectedDate, trades: trades))
        )
    }
    
    public static func calendarCellItems(
        date: Date,
        selectedDate: Date,
        trades: [Trade]
    ) -> [CalendarCellItem] {
        return date.allDatesInMonth().map { date in
            return .init(date: date, trades: trades.filter({ $0.date.isEqual(date: date) }), isSelected: date.isEqual(date: selectedDate))
        }
    }
}
