//
//  MainTabStore.swift
//  DyingFeature
//
//  Created by 송영모 on 2023/08/02.
//

import ComposableArchitecture

import ToffFeatureCalendarInterface
import ToffFeatureCalendar
import ToffFeaturePortfolioInterface
import ToffFeaturePortfolio
import ToffFeatureMyPageInterface
import ToffFeatureMyPage


public struct MainTabStore: Reducer {
    public init() {}
    
    public enum Tab: String {
        case calendar = "Calendar"
        case portfolio = "Portfolio"
        case myPage = "MyPage"
    }
    
    public struct State: Equatable {
        var calendar: ToffCalendarNavigationStackStore.State = .init()
        var portfolio: PortfolioNavigationStackStore.State = .init()
        var myPage: MyPageNavigationStackStore.State = .init()
        
        var currentTab: Tab = .calendar
        
        public init() { }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        case refresh
        
        case selectTab(Tab)
        
        case calendar(ToffCalendarNavigationStackStore.Action)
        case portfolio(PortfolioNavigationStackStore.Action)
        case myPage(MyPageNavigationStackStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .onAppear:
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
            ToffCalendarNavigationStackStore()
        }
        Scope(state: \.portfolio, action: /Action.portfolio) {
            PortfolioNavigationStackStore()
        }
        Scope(state: \.myPage, action: /Action.myPage) {
            MyPageNavigationStackStore()
        }
    }
}