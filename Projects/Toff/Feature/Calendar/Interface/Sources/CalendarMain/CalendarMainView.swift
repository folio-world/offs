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

public struct CalendarMainView: View {
    let store: StoreOf<CalendarMainStore>
    
    public init(store: StoreOf<CalendarMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                TabView(selection: viewStore.binding(get: \.currentTab, send: CalendarMainStore.Action.selectTab)) {
                    ForEachStore(self.store.scope(state: \.offCalendars, action: CalendarMainStore.Action.offCalendars(id:action:))) {
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
