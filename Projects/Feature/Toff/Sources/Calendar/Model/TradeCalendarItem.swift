//
//  TradeCalendarItem.swift
//  ToffFeature
//
//  Created by 송영모 on 1/8/24.
//

import Foundation

public struct TradeCalendarItem: Identifiable, Equatable {
    public var id: UUID
    
    public var cells: [TradeCalendarCellItem]
    
    public init(
        id: UUID = .init(),
        cells: [TradeCalendarCellItem] = []
    ) {
        self.id = id
        self.cells = cells
    }
}

public struct TradeCalendarCellItem: Identifiable, Equatable {
    public var id: UUID
    
    public init(
        id: UUID = .init()
    ) {
        self.id = id
    }
}
