//
//  RoutineItemCellView.swift
//  RoffFeatureRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import SwiftUI

import ComposableArchitecture

import RoffShared

public struct RoutineItemCellView: View {
    private let store: StoreOf<RoutineItemCellStore>
    
    public init(store: StoreOf<RoutineItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                tradeView(viewStore: viewStore)
            }
        }
    }
    
    private func tradeView(viewStore: ViewStoreOf<RoutineItemCellStore>) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .trailing) {
//                if viewStore.state.dateStyle != .none {
//                    Text(
//                        viewStore.trade.date.localizedString(
//                            dateStyle: viewStore.state.dateStyle,
//                            timeStyle: .none
//                        )
//                    )
//                    .font(.headline)
//                    .fontWeight(.semibold)
//                }
//                
//                if viewStore.state.timeStyle != .none {
//                    Text(
//                        viewStore.trade.date.localizedString(
//                            dateStyle: .none,
//                            timeStyle: viewStore.state.timeStyle
//                        )
//                    )
//                    .font(.caption2)
//                }
            }
            
//            viewStore.state.trade.ticker?.type.image
//                .font(.title3)
//                .foregroundStyle(viewStore.state.trade.side == .buy ? .pink : .mint)
            
        }
        .offMinimalBackgroundStyle()
        .onTapGesture {
            viewStore.send(.tapped)
        }
    }
}
