//
//  MainTabStore.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import ComposableArchitecture

import OffCore
import ToffDomain
import OffShared

public struct MainTabStore: Reducer {
    public init() {}
    
    public enum Tab {
        case home
        case calendar
        case portfolio
        case myPage
    }
    
    public struct State: Equatable {
        var home: HomeNavigationStackStore.State = .init()
        var calendar: CalendarNavigationStackStore.State = .init()
        var portfolio: PortfolioNavigationStackStore.State = .init()
        var myPage: MyPageNavigationStackStore.State = .init()
        
        var currentTab: Tab = .home
        
        public init() { }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case onAppear
        case refresh
        
        case selectTab(Tab)
        
        case home(HomeNavigationStackStore.Action)
        case calendar(CalendarNavigationStackStore.Action)
        case portfolio(PortfolioNavigationStackStore.Action)
        case myPage(MyPageNavigationStackStore.Action)
        
        case delegate
        
        enum Delegate {
            case onboardingRequired
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .onAppear:
                return .none
                
            case .refresh:
                state = .init()
                return .none
                
            case let .selectTab(tab):
                state.currentTab = tab
                return .none
                
            case .portfolio(.delegate(.deleted)):
                return .send(.refresh)
                
            default:
                return .none
            }
        }
        Scope(state: \.home, action: /Action.home) {
            HomeNavigationStackStore()._printChanges()
        }
        Scope(state: \.calendar, action: /Action.calendar) {
            CalendarNavigationStackStore()._printChanges()
        }
        Scope(state: \.portfolio, action: /Action.portfolio) {
            PortfolioNavigationStackStore()._printChanges()
        }
        Scope(state: \.myPage, action: /Action.myPage) {
            MyPageNavigationStackStore()._printChanges()
        }
    }
}
