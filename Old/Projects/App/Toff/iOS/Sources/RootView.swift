//
//  RootView.swift
//  Dying
//
//  Created by 송영모 on 2023/07/19.
//  Copyright © 2023 folio.world. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

import ToffFeature

struct RootView: View {
    let store: StoreOf<RootStore>
    
    init(store: StoreOf<RootStore>) {
        self.store = store
    }
    
    var body: some View {
        SwitchStore(self.store) {
            switch $0 {
            case .onboarding:
                CaseLet(/RootStore.State.onboarding, action: RootStore.Action.onboarding) {
                    OnboardingNavigationStackView(store: $0)
                }
            case .mainTab:
                CaseLet(/RootStore.State.mainTab, action: RootStore.Action.mainTab) {
                    MainTabView(store: $0)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}
