//
//  OffCalendarView.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 12/16/23.
//

import SwiftUI

public struct OffCalendarView<Cell: View, T>: View where T: Identifiable {
    let items: [T]
    let cell : (T) -> Cell
    
    var onTap: (T) -> ()
    
    public init(
        items: [T],
        @ViewBuilder cell : @escaping (T) -> Cell,
        onTap: @escaping (T) -> ()
    ) {
        self.items = items
        self.cell = cell
        self.onTap = onTap
    }
    
    public var body: some View {
        LazyVGrid(
            columns: .init(repeating: .init(.flexible()), count: 7), 
            spacing: .zero
        ) {
            ForEach(items) { item in
                cell(item)
                    .onTapGesture {
                        onTap(item)
                    }
            }
        }
    }
}
