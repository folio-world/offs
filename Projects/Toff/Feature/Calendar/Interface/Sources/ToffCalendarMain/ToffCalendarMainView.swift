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

import OffFeatureCalendarInterface
import ToffDomainTradeInterface

public struct ToffCalendarMainView: View {
    let store: StoreOf<ToffCalendarMainStore>
    
    public init(store: StoreOf<ToffCalendarMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                TabView(selection: viewStore.binding(get: \.currentTab, send: ToffCalendarMainStore.Action.selectTab)) {
                    ForEachStore(self.store.scope(state: \.offCalendars, action: ToffCalendarMainStore.Action.offCalendars(id:action:))) {
                        OffCalendarView<Trade>(store: $0)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
        }
    }
    
    private func calendarView(store: StoreOf<OffCalendarStore<Trade>>) -> some View {
        VStack {
            
        }
    }
}
