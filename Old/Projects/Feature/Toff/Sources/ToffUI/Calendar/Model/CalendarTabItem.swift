//
//  CalendarTabItem.swift
//  ToffFeature
//
//  Created by 송영모 on 1/13/24.
//

import Foundation
import IdentifiedCollections

import ToffDomain

public struct CalendarTabItem: Identifiable, Equatable {
    public let id: UUID
    
    public let date: Date
    public var selectedDate: Date
    public var cells: IdentifiedArrayOf<CalendarCellItem>

    public init(
        id: UUID = .init(),
        date: Date,
        selectedDate: Date,
        cells: IdentifiedArrayOf<CalendarCellItem>
    ) {
        self.id = id
        self.date = date
        self.selectedDate = selectedDate
        self.cells = cells
    }
}
