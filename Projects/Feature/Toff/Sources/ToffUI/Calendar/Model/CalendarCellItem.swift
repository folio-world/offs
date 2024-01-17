//
//  CalendarCellItem.swift
//  ToffFeature
//
//  Created by 송영모 on 1/13/24.
//

import Foundation

import Domain

public struct CalendarCellItem: Identifiable, Equatable {
    public let id: UUID = .init()
    
    let date: Date
    let trades: [Trade]
    var isSelected: Bool
    
    public init(
        date: Date,
        trades: [Trade],
        isSelected: Bool = false
    ) {
        self.date = date
        self.trades = trades
        self.isSelected = isSelected
    }
}
