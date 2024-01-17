//
//  CalendarTabItem.swift
//  ToffFeature
//
//  Created by 송영모 on 1/13/24.
//

import Foundation

import Domain

public struct CalendarTabItem: Identifiable, Equatable {
    public let id: UUID
    
    public let date: Date
    public var cells: [CalendarCellItem]
    
    public init(
        id: UUID = .init(),
        date: Date,
        cells: [CalendarCellItem]
    ) {
        self.id = id
        self.date = date
        self.cells = cells
    }
}
