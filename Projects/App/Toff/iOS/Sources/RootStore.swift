//
//  RootStore.swift
//  DyingIOS
//
//  Created by 송영모 on 2023/08/02.
//  Copyright © 2023 folio.world. All rights reserved.
//

import ComposableArchitecture

import ToffFeature

struct RootStore: Reducer {
    enum State {
        case onboarding(OnboardingNavigationStackStore.State = .init())
        case mainTab(MainTabStore.State = .init())

        init() {
            self = .mainTab(.init())
        }
    }
    
    enum Action {
        case onboarding(OnboardingNavigationStackStore.Action)
        case mainTab(MainTabStore.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default: return .none
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
