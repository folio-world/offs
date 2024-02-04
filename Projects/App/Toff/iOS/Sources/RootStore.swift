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
        case dimmed

        init() {
            self = .dimmed
        }
    }
    
    enum Action {
        case onAppear
        
        case userResponse(Result<UserEntity, any Error>)
        
        case onboarding(OnboardingNavigationStackStore.Action)
        case mainTab(MainTabStore.Action)
    }
    
    @Dependency(\.authUseCase) var authUseCase
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.userResponse(Result { try await authUseCase.user() }))
                }
                
            case let .userResponse(result):
                switch result {
                case .success:
                    state = .mainTab(.init())
                    return .none
                case .failure(let error):
                    print(error)
                    state = .onboarding(.init())
                    return .none
                }
                
            case .onboarding(_):
                return .none
                
            case .mainTab(_):
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
