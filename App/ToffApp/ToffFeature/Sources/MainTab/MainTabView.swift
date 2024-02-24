//
//  MainTabView.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import SwiftUI

import ComposableArchitecture

public struct MainTabView: View {
    typealias State = MainTabStore.State
    typealias Action = MainTabStore.Action
    typealias Tab = MainTabStore.Tab
    
    let store: StoreOf<MainTabStore>
    
    public init(store: StoreOf<MainTabStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: \.currentTab) { viewStore in
            TabView(selection: viewStore.binding(get: { $0 }, send: Action.selectTab)) {
                HomeNavigationStackView(store: self.store.scope(state: \.home, action: Action.home))
                    .tabItem {
                        Image(systemName: "sparkles")
                    }
                    .tag(Tab.home)
                
                CalendarNavigationStackView(store: self.store.scope(state: \.calendar, action: Action.calendar))
                    .tabItem {
                        Image(systemName: "calendar")
                    }
                    .tag(Tab.calendar)
                
                PortfolioNavigationStackView(store: self.store.scope(state: \.portfolio, action: Action.portfolio))
                    .tabItem {
                        Image(systemName: "chart.bar.doc.horizontal")
                    }
                    .tag(Tab.portfolio)
                
                MyPageNavigationStackView(store: self.store.scope(state: \.myPage, action: Action.myPage))
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                    }
                    .tag(Tab.myPage)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
            .accentColor(Color.foreground)
        }
    }
}
