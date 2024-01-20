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

import IdentifiedCollections

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
            OffCalendarView(items: item.cells.elements) { item in
                CalendarCellView(item: item)
                    .frame(height: proxy.size.height * 0.12)
            } onTap: { item in
                calendarCellItemTapped(item)
            }
            .tag(item.id)
            .padding(.top, 40)

            tradeSection(date: item.selectedDate, trades: item.cells.filter({ $0.isSelected }).flatMap { $0.trades })
        }
    }

    private func tradeSection(date: Date, trades: [Trade]) -> some View {
        VStack {
            tradeHeaderView(date: date)
            
            VStack {
                ForEach(trades) { trade in
                    tradeItemView(trade: trade)
                        .offAnimatedButton { tradeItemTapped(trade) }
                }
                
                newTradeItemView()
                    .offAnimatedButton { newTradeItemTapped() }
            }
        }
    }
    
    private func tradeHeaderView(date: Date) -> some View {
        HStack {
            Text(date.localizedString(dateStyle: .medium, timeStyle: .none))
                .font(OffTypo.title.font)

            Spacer()
        }
    }
    
    private func tradeItemView(trade: Trade) -> some View {
        HStack {
            OffIconView(appearance: .circle(icon: trade.ticker?.type.icon ?? .cube, size: .small, color: .init(kind: .grey00)))
            
            VStack(alignment: .leading) {
                Text(trade.ticker?.name ?? "")
                    .offTypo(.body)
                
                Text(trade.date.localizedString(dateStyle: .none, timeStyle: .medium))
                    .offTypo(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(priceString(trade: trade))
                    .offTypo(.caption)
                
                Text(quantityString(trade: trade))
                    .offTypo(.caption)
            }
        }
    }
    
    private func newTradeItemView() -> some View {
        HStack {
            OffIconView(appearance: .plain(icon: .plus, size: .small, color: .init(kind: .grey00)))
            
            Text("새로운 거래 기록")
                .offTypo(.body)
            
            Spacer()
        }
    }
    
    private func priceString(trade: Trade) -> String {
        return "\(Int(trade.price)) \(trade.ticker?.currency.rawValue ?? "")"
    }
    
    private func quantityString(trade: Trade) -> String {
        return "\(Int(trade.quantity))"
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
