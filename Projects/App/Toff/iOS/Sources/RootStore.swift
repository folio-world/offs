//
//  RootStore.swift
//  DyingIOS
//
//  Created by 송영모 on 2023/08/02.
//  Copyright © 2023 folio.world. All rights reserved.
//

import ComposableArchitecture

import ToffFeature
import ToffDomain

struct RootStore: Reducer {
    enum State {
        case onboarding(OnboardingNavigationStackStore.State = .init())
        case mainTab(MainTabStore.State = .init())

        init() {
            self = .mainTab()
        }
    }
    
    enum Action {
        case onAppear
        
        case refreshResponse(Result<Void, any Error>)
        case userResponse(Result<UserEntity, any Error>)
        
        case onboarding(OnboardingNavigationStackStore.Action)
        case mainTab(MainTabStore.Action)
    }
    
    @Dependency(\.authClient) var authClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.refreshResponse(Result { try await authClient.refresh() }))
                }
                
            case let .refreshResponse(result):
                switch result {
                case .success:
                    return .run { send in
                        await send(.userResponse(Result { try await authClient.user() }))
                    }
                case .failure:
                    state = .onboarding(.init())
                    return .none
                }
                
            case let .userResponse(result):
                switch result {
                case .success:
                    state = .mainTab(.init())
                    return .none
                case .failure:
                    state = .onboarding(.init())
                    return .none
                }
                
            case .onboarding(.signIn(.delegate(.signIn))):
                state = .mainTab(.init())
                return .none
                
            case .onboarding:
                return .none
                
            case .mainTab:
                return .none
            }
        }
        .ifCaseLet(/State.onboarding, action: /Action.onboarding) {
            OnboardingNavigationStackStore()
        }
        .ifCaseLet(/State.mainTab, action: /Action.mainTab) {
            MainTabStore()
        }
    }
}
