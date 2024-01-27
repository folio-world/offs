//
//  OnboardingSignUpStore.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import ComposableArchitecture

public struct OnboardingSignUpStore: Reducer {
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case signIn(code: String, idToken: String)
        
        case appleLoginRequest(code: String, idToken: String)
        case appleLoginResponse

        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case signIn
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .signIn(code: code, idToken: idToken):
                return .send(.appleLoginRequest(code: code, idToken: idToken))
                
            case let .appleLoginRequest(code: code, idToken: idToken):
                return .none
                
            default:
                return .none
            }
        }
    }
}
