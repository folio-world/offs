//
//  RootGoalStore.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import ComposableArchitecture

public struct HomeNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: HomeMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case main(HomeMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case detail(TradeDetailStore.State)
        }
        
        public enum Action: Equatable {
            case detail(TradeDetailStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.detail, action: /Action.detail) {
                TradeDetailStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case .path(.element(id: _, action: .detail(.delegate(.delete)))):
                state.path.removeLast()
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.main, action: /Action.main) {
            HomeMainStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
