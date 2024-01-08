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

public struct ToffCalendarMainView: View {
    let store: StoreOf<ToffCalendarMainStore>
    
    public init(store: StoreOf<ToffCalendarMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: \.currentTab) { viewStore in
            GeometryReader { proxy in
                TabView(
                    selection: viewStore.binding(
                        get: { state in state },
                        send: ToffCalendarMainStore.Action.selectTab
                    )
                ) {
                    calendarTabView
                    
//                    ForEachStore(self.store.scope(state: \.offCalendars, action: ToffCalendarMainStore.Action.offCalendars(id:action:))) {
//                        calendarTabView(store: $0, viewStore: viewStore, proxy: proxy)
//                            .frame(width: proxy.size.width, height: proxy.size.height)
//                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
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
    
    private var calendarTabView: some View {
        WithViewStore(self.store, observe: \.calendarItems) { viewStore in
            ForEach(viewStore.state) { item in
                OffCalendarView(
                    items: item.cells,
                    onTap: { _ in },
                    cell: { _ in Text("hi")}
                )
            }
        }
    }
    
//    private func calendarTabView(
//        store: StoreOf<OffCalendarStore<Trade>>,
//        viewStore: ViewStoreOf<ToffCalendarMainStore>,
//        proxy: GeometryProxy
//    ) -> some View {
//        ZStack {
//            ScrollView {
//                VStack {
////                    OffCalendarView(items: viewStore.state.trades) { item in
////                        
////                    }
//                    
//                    OffCalendarView(
//                        items: viewStore,
//                        onTap: <#T##(Identifiable) -> ()#>,
//                        cell: { _ in VStack { "Text" } }
//                    )
//                    
//                    tradeItemsView(viewStore: viewStore)
//                    
//                    Spacer()
//                }
//                .padding(10)
//            }
//            
//            headerView(viewStore: viewStore)
//        }
//    }
    
    private func headerView(viewStore: ViewStoreOf<ToffCalendarMainStore>) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(Calendar.current.shortMonthSymbols[viewStore.state.headerDate.month - 1])".uppercased())
                    .font(.largeTitle)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .background(Color(uiColor: .systemBackground).opacity(0.7))
            
            Spacer()
        }
    }
    
    private func tradeItemsView(viewStore: ViewStoreOf<ToffCalendarMainStore>) -> some View {
        VStack(alignment: .leading) {
            Text(viewStore.state.selectedDate.localizedString(dateStyle: .medium, timeStyle: .none))
                .font(.title3)
                .fontWeight(.bold)
            
            ForEachStore(self.store.scope(state: \.tradeItems, action: ToffCalendarMainStore.Action.tradeItems(id:action:))) {
                TradeItemCellView(store: $0)
            }
            
            TradeNewItem() {
                viewStore.send(.newButtonTapped)
            }
        }
    }
}
