//
//  OnboardingSignUpStore.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import Foundation
import OSLog

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
    
    @Dependency(\.authClient) var authClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .signIn(idToken: idToken):
                return .run { send in
                    await send(.signInResponse(Result { try await authClient.signIn(idToken) }))
                }
                
            case let .signInResponse(result):
                switch result {
                case let .success(session):
                    let logger = Logger()
                    logger.info("sigIn")
                case let .failure(error):
                    let logger = Logger()
                    logger.info("sigIn failure \(error)")
                    print(error)
                }
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}
