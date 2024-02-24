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

import ToffDomain
import SharedDesignSystem

public struct CalendarMainView: View {
    typealias State = CalendarMainStore.State
    typealias Action = CalendarMainStore.Action
    
    let store: StoreOf<CalendarMainStore>
    
    public init(store: StoreOf<CalendarMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        containerView
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onAppear {
                store.send(.onAppear)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$selectTicker,
                    action: { .selectTicker($0) }
                )
            ) {
                SelectTickerView(store: $0)
                    .presentationDetents([.medium])
            }
            .sheet(
                store: self.store.scope(
                    state: \.$editTrade,
                    action: { .editTrade($0) }
                )
            ) {
                EditTradeView(store: $0)
                    .presentationDetents([.medium])
            }
    }
}

extension CalendarMainView {
    private var containerView: some View {
        ZStack(alignment: .top) {
            tabView
                .padding(.horizontal)

            headerView
        }
    }
    
    private var headerView: some View {
        WithViewStore(store, observe: \.headerDate) { viewStore in
            HStack {
                Text("\(Calendar.current.shortMonthSymbols[viewStore.state.month - 1])".uppercased())
                    .font(.largeTitle)
                
                Spacer()
            }
            .padding(.horizontal)
            .background(Color(uiColor: .systemBackground).opacity(0.7))
        }
    }
    
    private struct TabViewState: Equatable {
        var currentTab: UUID
        let tabItems: IdentifiedArrayOf<CalendarTabItem>

        init(_ state: State) {
            self.currentTab = state.currentTab
            self.tabItems = state.calendarTabItems
        }
    }
    
    private var tabView: some View {
        WithViewStore(self.store, observe: TabViewState.init) { viewStore in
            GeometryReader { proxy in
                CalendarTabView(
                    proxy: proxy,
                    tab: viewStore.binding(get: \.currentTab, send: Action.selectTab),
                    items: viewStore.tabItems.elements,
                    calendarCellItemTapped: { viewStore.send(.calendarCellItemTapped($0)) },
                    tradeItemTapped: { viewStore.send(.tradeItemTapped($0)) },
                    newTradeItemTapped: { viewStore.send(.newTradeItemTapped) }
                )
            }
        }
    }
}
