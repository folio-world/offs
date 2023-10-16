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
import RoffFeatureRoutineInterface
import RoffDomain
import RoffShared

public struct RoffCalendarMainView: View {
    let store: StoreOf<RoffCalendarMainStore>
    
    public init(store: StoreOf<RoffCalendarMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                TabView(selection: viewStore.binding(get: \.currentTab, send: RoffCalendarMainStore.Action.selectTab)) {
                    ForEachStore(self.store.scope(state: \.offCalendars, action: RoffCalendarMainStore.Action.offCalendars(id:action:))) {
                        calendarTabView(store: $0, viewStore: viewStore, proxy: proxy)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .onAppear {
                viewStore.send(.onAppear, animation: .default)
            }
            .sheet(
                store: self.store.scope(
                    state: \.$editRoutine,
                    action: { .editRoutine($0) }
                )
            ) {
                EditRoutineView(store: $0)
                    .presentationDetents([.medium])
            }
        }
    }
    
    private func calendarTabView(
        store: StoreOf<OffCalendarStore<Routine>>,
        viewStore: ViewStoreOf<RoffCalendarMainStore>,
        proxy: GeometryProxy
    ) -> some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack(alignment: .leading) {
                    OffCalendarView<Routine>(store: store, proxy: proxy)
                        .padding(.top, 40)
                    
                    Text(viewStore.state.selectedDate.localizedString(dateStyle: .medium, timeStyle: .none))
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    ForEachStore(self.store.scope(state: \.routineItems, action: RoffCalendarMainStore.Action.routineItems(id:action:))) {
                        RoutineItemCellView(store: $0)
                    }
                    
                    OffTitleButton(title: "New") {
                        viewStore.send(.newButtonTapped)
                    }
                }
                .padding(10)
            }
            
            HStack {
                Text("\(Calendar.current.shortMonthSymbols[viewStore.state.headerDate.month - 1])".uppercased())
                    .font(.largeTitle)
                
                Spacer()
            }
            .padding(.horizontal, 10)
            .background(.background.opacity(0.7))
        }
    }
}
