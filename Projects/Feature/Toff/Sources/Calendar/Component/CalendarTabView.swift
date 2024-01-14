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
    
    let proxy: GeometryProxy
    let items: [CalendarTabItem]
    var onTap: (CalendarCellItem) -> ()
    
    public init(
        proxy: GeometryProxy,
        tab: Binding<UUID>,
        items: [CalendarTabItem],
        onTap: @escaping (CalendarCellItem) -> Void
    ) {
        self.proxy = proxy
        self._tab = tab
        self.items = items
        self.onTap = onTap
    }
    
    public var body: some View {
        TabView(selection: $tab) {
            ForEach(items) { item in
                OffCalendarView(items: item.cells) { item in
                    CalendarCellView(item: item)
                        .frame(height: proxy.size.height * 0.12)
                } onTap: { item in
                    onTap(item)
                }
                .tag(item.id)
            }
        }
    }
}
