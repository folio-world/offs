//
//  OnboardingNavigationStackStore.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import ComposableArchitecture

public struct OnboardingNavigationStackStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var path: StackState<Path.State> = .init()
        
        var signIn: OnboardingSignInStore.State = .init()
        
        public init() {}
    }
    
    public enum Action {
        case onAppear
        
        case signIn(OnboardingSignInStore.Action)
        case path(StackAction<Path.State, Path.Action>)
    }
    
    public struct Path: Reducer {
        public enum State: Equatable {
            case wip(WIPStore.State)
        }
        
        public enum Action: Equatable {
            case wip(WIPStore.Action)
        }
        
        public var body: some Reducer<State, Action> {
            Scope(state: /State.wip, action: /Action.wip) {
                WIPStore()
            }
        }
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.signIn, action: /Action.signIn) {
            OnboardingSignInStore()
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}
