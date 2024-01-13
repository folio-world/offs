//
//  CalendarTabView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/13/24.
//

import Foundation
import SwiftUI

import SharedDesignSystem
import Domain

public struct CalendarTabView: View {
    @Binding var tab: UUID
    
    let items: [CalendarTabItem]
    var onTap: (CalendarCellItem) -> ()
    
    public init(
        tab: Binding<UUID>,
        items: [CalendarTabItem],
        onTap: @escaping (CalendarCellItem) -> Void
    ) {
        self._tab = tab
        self.items = items
        self.onTap = onTap
    }
    
    public var body: some View {
        TabView(selection: $tab) {
            ForEach(items) { item in
                OffCalendarView(items: item.cells) { item in
                    CalendarCellView(item: item)
                } onTap: { item in
                    onTap(item)
                }
                .tag(item.id)
            }
        }
    }
}
