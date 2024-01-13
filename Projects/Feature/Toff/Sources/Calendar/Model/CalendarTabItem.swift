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
    
    let cells: [CalendarCellItem]
    
    public init(
        id: UUID = .init(),
        cells: [CalendarCellItem]
    ) {
        self.id = id
        self.cells = cells
    }
}
