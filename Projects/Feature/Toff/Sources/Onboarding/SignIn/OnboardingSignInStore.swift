//
//  OnboardingSignUpStore.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import ComposableArchitecture
import Auth

public struct OnboardingSignInStore: Reducer {
    public struct State: Equatable {
        public init() { }
    }
    
    public enum Action {
        case onAppear
        
        case signIn(idToken: String)
        case signInResponse(Result<Void, any Error>)

        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case signIn
        }
    }
    
    @Dependency(\.authUseCase) var authUseCase
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .signIn(idToken: idToken):
                return .run { send in
                    await send(.signInResponse(Result { try await authUseCase.signIn(idToken: idToken) }))
                }
                
            case let .signInResponse(result):
                switch result {
                case let .success(session):
                    print(session)
                case let .failure(error):
                    print(error)
                }
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
