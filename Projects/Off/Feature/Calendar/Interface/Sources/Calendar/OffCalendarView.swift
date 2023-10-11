//
//  OffCalendarView.swift
//  OffFeatureCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct OffCalendarView<T: Equatable>: View {
    let store: StoreOf<OffCalendarStore<T>>
    
    public init(store: StoreOf<OffCalendarStore<T>>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                ZStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: .zero) {
                            calendarView(viewStore: viewStore, proxy: proxy)
                                .padding([.horizontal, .bottom], 10)
                            
//                            tradeItemList(viewStore: viewStore)
//                                .padding(.horizontal, 10)
                            
                            Spacer()
                        }
                        .padding(.top, 45)
                    }
                    .refreshable {
//                        viewStore.send(.refreshScroll)
                    }
                    
//                    header(viewStore: viewStore)
                }
            }
        }
    }
    
    private func calendarView(viewStore: ViewStoreOf<OffCalendarStore<T>>, proxy: GeometryProxy) -> some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
            ForEachStore(self.store.scope(state: \.offCalendars, action: OffCalendarStore.Action.offCalendars(id:action:))) {
                OffCalendarCellView(store: $0)
                    .frame(height: proxy.size.height * 0.12)
            }
            Spacer()
        }
    }
}
