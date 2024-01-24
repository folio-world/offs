//
//  CalendarMainView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI
import SwiftData
import Combine
import ComposableArchitecture

import Domain
import SharedDesignSystem

public struct HomeMainView: View {
    typealias State = HomeMainStore.State
    typealias Action = HomeMainStore.Action
    
    let store: StoreOf<HomeMainStore>
    
    public init(store: StoreOf<HomeMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("581,515,244 WON")
                        .offTypo(.largeTitle)
                    
                    Spacer()
                }
                
                tickerSectionView()
            }
        }
        .onAppear { store.send(.onAppear) }
    }
    
    private func tickerSectionView() -> some View {
        WithViewStore(store, observe: \.tickers) { viewStore in
            HStack {
                Text("거래")
                    .offTypo(.title)
                
                Spacer()
            }
            
            ForEach(viewStore.state) { ticker in
                tickerItemView(ticker: ticker)
            }
        }
    }
    
    private func tickerItemView(ticker: Ticker) -> some View {
        HStack {
            OffIconView(
                appearance: .circle(
                    icon: ticker.type.icon,
                    size: .medium,
                    color: .init(kind: .red)))
            
            VStack(alignment: .leading) {
                Text(ticker.name)
                    .offTypo(.body)
            }
            
            Spacer()
        }
    }
}
