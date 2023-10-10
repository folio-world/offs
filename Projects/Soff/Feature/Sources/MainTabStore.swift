//
//  MainTabStore.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import ComposableArchitecture

import SoffFeatureCalendarInterface
import SoffFeatureCalendar
import SoffFeaturePortfolioInterface
import SoffFeaturePortfolio
import SoffFeatureMyPageInterface
import SoffFeatureMyPage
import SoffDomain


public struct MainTabStore: Reducer {
    public init() {}
    
    public enum Tab: String {
        case calendar = "Calendar"
        case portfolio = "Portfolio"
        case myPage = "MyPage"
    }
    
    public struct State: Equatable {
        var calendar: CalendarNavigationStackStore.State = .init()
        var portfolio: PortfolioNavigationStackStore.State = .init()
        var myPage: MyPageNavigationStackStore.State = .init()
        
        var currentTab: Tab = .calendar
        
        public init() { }
    }
    
    @Dependency(\.tradeClient) var tradeClient
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        case refresh
        
        case selectTab(Tab)
        
        case calendar(CalendarNavigationStackStore.Action)
        case portfolio(PortfolioNavigationStackStore.Action)
        case myPage(MyPageNavigationStackStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .onAppear:
                if let tt = try? tradeClient.fetchTrades().get() {
                    print("[D] \(tt.first?.ticker?.name)")
                    return .none
                }
                return .send(.refresh)
                
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
