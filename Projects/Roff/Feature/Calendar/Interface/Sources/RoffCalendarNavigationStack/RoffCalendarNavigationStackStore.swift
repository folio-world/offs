//
//  RootGoalStore.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import ComposableArchitecture

import RoffFeatureRoutineInterface

public struct RoffCalendarNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var main: RoffCalendarMainStore.State = .init()
        
        public init() {}
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case main(RoffCalendarMainStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case detail(RoutineDetailStore.State)
        }
        
        public enum Action: Equatable {
            case detail(RoutineDetailStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.detail, action: /Action.detail) {
                RoutineDetailStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .main(.delegate(.detail(trade))):
                state.path.append(.detail(.init()))
                return .none
                
            case .path(.element(id: _, action: .detail(.delegate(.delete)))):
                state.path.removeLast()
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.main, action: /Action.main) {
            RoffCalendarMainStore()
        }
        
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
