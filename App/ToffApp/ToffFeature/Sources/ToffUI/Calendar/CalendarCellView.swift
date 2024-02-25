//
//  CalendarCellView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/13/24.
//

import Foundation
import SwiftUI
import OffSharedDesignSystem

import ToffDomain

public struct CalendarCellView: View {
    let item: CalendarCellItem
    
    public var body: some View {
        containerView(item: item)
            .background(item.isSelected ? OffColor(kind: .grey00).color : OffColor(kind: .grey100).color)
            .clipShape(RoundedRectangle(cornerRadius: 8,style: .continuous))
    }
}

extension CalendarCellView {
    private func containerView(item: CalendarCellItem) -> some View {
        VStack(spacing: 2) {
            headerView(date: item.date)
                .padding(.top, 2)
            
            ForEach(item.trades.prefix(3)) { trade in
                tradeItemView(trade: trade, isSelected: item.isSelected)
            }
            .padding(.horizontal, 1)
            
            Spacer()
        }
    }
    
    private func headerView(date: Date) -> some View {
        HStack {
            Spacer()
            
            Text("\(date.day)")
                .offTypo(.body)
                .foregroundStyle(item.isSelected ? OffColor(kind: .grey100).color : OffColor(kind: .grey00).color)
            
            Spacer()
        }
    }
    
    private func tradeItemView(trade: Trade, isSelected: Bool) -> some View {
        HStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 3)
                .fill(trade.side == .buy ? OffColor(kind: .red).color : OffColor(kind: .blue).color)
                .frame(width: 2, height: 10)
            
            Text(trade.ticker?.name ?? "")
                .offTypo(.caption2)
                .foregroundStyle(isSelected ? OffColor(kind: .grey100).color : OffColor(kind: .grey00).color)
            
            Spacer()
        }
    }
}
