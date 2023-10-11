//
//  OffCalendarEntity.swift
//  OffDomainCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation

public struct OffCalendarItem<T: Equatable>: Equatable, Identifiable {
    public let id: UUID
    public let date: Date
    public let previewItems: [OffCalendarPreviewItem]
    
    public let data: [T]
    
    public init(
        id: UUID = .init(),
        date: Date,
        previewItems: [OffCalendarPreviewItem] = [],
        data: [T] = []
    ) {
        self.id = id
        self.date = date
        self.previewItems = previewItems
        self.data = data
    }
}
