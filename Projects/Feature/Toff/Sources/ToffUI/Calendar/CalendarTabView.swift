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
    var calendarCellItemTapped: (CalendarCellItem) -> ()
    var tradeItemTapped: (Trade) -> ()
    var newTradeItemTapped: () -> ()
    
    public init(
        proxy: GeometryProxy,
        tab: Binding<UUID>,
        items: [CalendarTabItem],
        calendarCellItemTapped: @escaping (CalendarCellItem) -> Void,
        tradeItemTapped: @escaping (Trade) -> Void,
        newTradeItemTapped: @escaping () -> Void
    ) {
        self.proxy = proxy
        self._tab = tab
        self.items = items
        self.calendarCellItemTapped = calendarCellItemTapped
        self.tradeItemTapped = tradeItemTapped
        self.newTradeItemTapped = newTradeItemTapped
    }
    
    public var body: some View {
        tabView
    }
}

extension CalendarTabView {
    private var tabView: some View {
        TabView(selection: $tab) {
            ForEach(items) { item in
                containerView(item: item)
            }
        }
    }
    
    private func containerView(item: CalendarTabItem) -> some View {
        ScrollView {
            OffCalendarView(items: item.cells) { item in
                CalendarCellView(item: item)
                    .frame(height: proxy.size.height * 0.12)
            } onTap: { item in
                calendarCellItemTapped(item)
            }
            .tag(item.id)
            .padding(.top, 40)
            
            tradeItemsView(trades: item.cells.filter({ $0.isSelected }).flatMap { $0.trades })
                .padding(.horizontal)
        }
    }
    
    private func tradeItemsView(trades: [Trade]) -> some View {
        VStack {
            VStack {
                ForEach(trades) { trade in
                    OffIconButtonView(
                        appearance: .plain(icon: trade.ticker?.type.icon ?? .cube, title: trade.ticker?.name ?? "", typo: .body),
                        isPressed: false
                    ) {
                        tradeItemTapped(trade)
                    }
                }
                
                OffIconButtonView(
                    appearance: .plain(icon: .plus, title: "새로운 거래 기록", typo: .body),
                    isPressed: false
                ) {
                    newTradeItemTapped()
                }
            }
        }
    }
}

extension TickerType {
    var icon: OffIcon {
        switch self {
        case .stock: return .stock
        case .crypto: return .cube
        case .gold: return .cube
        case .realEstate: return .cube
        }
    }
}
