//
//  CalendarObjectMapper.swift
//  ToffFeature
//
//  Created by 송영모 on 1/8/24.
//

import Foundation
import Domain

public struct CalendarObjectMapper {
    public static func calendarTabItem(date: Date, trades: [Trade]) -> CalendarTabItem {
        return .init(
            cells: calendarCellItems(date: date, trades: trades)
        )
    }
    
    private static func calendarCellItems(date: Date, trades: [Trade]) -> [CalendarCellItem] {
        return date.allDatesInMonth().map { date in
            return .init(date: date, trades: trades.filter({ $0.date.isEqual(date: date) }))
        }
    }
}
