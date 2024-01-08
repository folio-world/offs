//
//  CalendarObjectMapper.swift
//  ToffFeature
//
//  Created by 송영모 on 1/8/24.
//

import Foundation
import Domain

public struct CalendarObjectMapper {
    public static func tradeCalendarItems(at date: Date, from trades: [Trade]) -> [TradeCalendarItem] {
        let dates = date.allDatesInMonth()
        
        return dates.map { date in
            TradeCalendarItem()
        }
    }
}
