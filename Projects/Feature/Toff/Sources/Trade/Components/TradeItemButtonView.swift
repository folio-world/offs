//
//  TradeItemButtonView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/15/24.
//

import Foundation
import SwiftUI

import Domain
import SharedDesignSystem

public struct TradeItemButtonView: View {
    let trade: Trade
    
    var onTap: (Trade) -> ()
    
    init(trade: Trade, onTap: @escaping (Trade) -> Void) {
        self.trade = trade
        self.onTap = onTap
    }
    
    public var body: some View {
        OffIconButtonView(appearance: .rounded(icon: .circle(icon: .stock, size: .medium, color: .init(kind: .pink)), title: trade.ticker?.name ?? "", typo: .body)) {
            onTap(trade)
        }
    }
}
