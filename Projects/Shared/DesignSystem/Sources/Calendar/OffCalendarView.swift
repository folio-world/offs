//
//  OffCalendarView.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 12/16/23.
//

import SwiftUI

public struct OffCalendarPreviewItem: Identifiable {
    public var id: UUID
    
    public var title: String
    
    public init(
        id: UUID = .init(),
        title: String = ""
    ) {
        self.id = id
        self.title = title
    }
}

public struct OffCalendarItem: Identifiable {
    public var id: UUID
    
    public var title: String
    public var previews: [OffCalendarPreviewItem] = []
    
    public init(
        id: UUID = .init(),
        title: String = "",
        previews: [OffCalendarPreviewItem] = []
    ) {
        self.id = id
        self.title = title
        self.previews = previews
    }
}

public struct OffCalendarView<Cell: View>: View {
    let items: [OffCalendarItem]
    let cell : (OffCalendarItem) -> Cell
    
    public init(
        items: [OffCalendarItem],
        @ViewBuilder cell : @escaping (OffCalendarItem) -> Cell
    ) {
        self.items = items
        self.cell = cell
    }
    
    public var body: some View {
        LazyVGrid(
            columns: .init(repeating: .init(.flexible()), count: 7), 
            spacing: .zero
        ) {
            ForEach(items) { item in
                cell(item)
            }
        }
    }
}
