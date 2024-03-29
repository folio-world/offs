//
//  TickerDetailView.swift
//  ToolinderFeaturePortfolioDemo
//
//  Created by 송영모 on 2023/09/25.
//

import SwiftUI

import ComposableArchitecture

import ToffDomain
import OffShared

public struct TickerDetailView: View {
    private let store: StoreOf<TickerDetailStore>
    
    public init(store: StoreOf<TickerDetailStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                ScrollView {
                    VStack {
                        TradeDateChartView(tradeDateChartDataEntity: viewStore.state.tradeDateChartDataEntity)
                            .padding()
                        
                        tradeListView(viewStore: viewStore)
                            .padding(.horizontal)
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$editTicker,
                    action: { .editTicker($0) }
                )
            ) {
                EditTickerView(store: $0)
                    .presentationDetents([.medium])
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit") {
                        viewStore.send(.editButtonTapped)
                    }
                }
            }
            .navigationTitle(viewStore.state.ticker.name)
        }
    }
    
    private func titleView() -> some View {
        VStack {
            
        }
    }
    
    private func tradeListView(viewStore: ViewStoreOf<TickerDetailStore>) -> some View {
        VStack {
            HStack {
                Label("History", systemImage: "clock")
                    .font(.headline)
                Spacer()
            }
            .padding(.bottom, 5)
            
            ForEachStore(self.store.scope(state: \.tradeItem, action: TickerDetailStore.Action.tradeItem(id:action:))) {
                TradeItemCellView(store: $0)
            }
        }
    }
}
