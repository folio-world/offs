//
//  Trade+SharedDesignSystem.swift
//  Domain
//
//  Created by 송영모 on 1/1/24.
//

import Foundation

import SharedDesignSystem

public struct TradeObjectMapper {
    static func OffCalendarItemsOfMonth(date: Date, trades: [Trade]) -> [OffCalendarItem] {
        let dates = date.allDatesInMonth()
        
        return dates.map { date in
            OffCalendarItem(
                title: "\(date.day)",
                previews: trades.filter({ $0.date.isEqual(date: date) }).map { .init(title: $0.ticker?.name ?? "") }
            )
        }
    }
}
