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
    @SwiftUI.State var isToggleOn: Bool = true
    
    public init(store: StoreOf<HomeMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                assetSectionView()
                    .padding(.bottom, 100)
                
                tickerSectionView()
            }
            .padding()
        }
        .onAppear { store.send(.onAppear) }
    }
    
    private func assetSectionView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("자산")
                .offTypo(.largeTitle)

            HStack {
                OffIconView(
                    appearance: .circle(
                        icon: .globe,
                        size: .medium,
                        foregroundColor: .init(kind: .grey100),
                        backgroundColor: .init(kind: .grey00)
                    )
                )
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("581,515,244 WON")
                        .offTypo(.body)
                    
                    Text("+105,200원(0.27%)")
                        .offTypo(.caption)
                }
            }
        }
    }
    
    private func tickerSectionView() -> some View {
        WithViewStore(store, observe: \.tickers) { viewStore in
            VStack(alignment: .leading) {
                HStack {
                    Text("거래")
                        .offTypo(.largeTitle)
                    
                    Toggle("", isOn: $isToggleOn)
                }
                .padding(.bottom, 5)
                
                HStack {
                    Text("전체")

                    Text("현금")
                    Text("주식")
                    Text("코인")
                    Text("부동산")
                }
                .offTypo(.body)
                
                VStack(spacing: 15) {
                    ForEach(viewStore.state) { ticker in
                        tickerItemView(ticker: ticker)
                            .offAnimatedButton {
                                print("hi")
                            }
                    }
                }
                .padding(.bottom, 20)
                
                HStack {
                    HStack {
                        OffIconView(appearance: .plain(icon: .gearshape, size: .small, color: .init(kind: .grey00)))
                        
                        Text("설정")
                            .offTypo(.body)
                        
                        Spacer()
                    }
                    .offAnimatedButton {
                        
                    }
                    
                    HStack {
                        OffIconView(appearance: .plain(icon: .plus, size: .small, color: .init(kind: .grey00)))
                        
                        Text("새로운 거래 기록")
                            .offTypo(.body)
                        
                        Spacer()
                    }
                    .offAnimatedButton {
                        
                    }
                }
            }
        }
    }
    
    private func tickerItemView(ticker: Ticker) -> some View {
        HStack {
            OffIconView(
                appearance: .circle(
                    icon: ticker.type.icon,
                    size: .medium,
                    foregroundColor: .init(kind: .grey100),
                    backgroundColor: .init(kind: .grey00)
                )
            )
            
            VStack(alignment: .leading) {
                Text(ticker.name)
                    .offTypo(.body)
                
                Text(volumeString(ticker: ticker))
                    .offTypo(.caption)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("144,000원")
                    .offTypo(.body)
                
                Text("+284,067원(0.44%)")
                    .offTypo(.caption)
            }
        }
    }
    
    private func volumeString(ticker: Ticker) -> String {
        let sum = ticker.trades?.reduce(0, { $0 + ($1.side == .buy ? $1.quantity : -$1.quantity) } )
        
        return "\(Int(sum ?? 0))"
    }
}
