//
//  OnboardingNavigationStackView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import SwiftUI

import ComposableArchitecture

public struct OnboardingNavigationStackView: View {
    let store: StoreOf<OnboardingNavigationStackStore>
    
    public init(store: StoreOf<OnboardingNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: OnboardingNavigationStackStore.Action.path)
        ) { WithViewStore(self.store, observe: { $0 }) { viewStore in
            OnboardingMainView(
                store: self.store.scope(
                    state: \.main,
                    action: OnboardingNavigationStackStore.Action.main)
            )
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        } destination: {
            switch $0 {
            case .wip:
                CaseLet(
                    /OnboardingNavigationStackStore.Path.State.wip,
                     action: OnboardingNavigationStackStore.Path.Action.wip,
                     then: WIPView.init(store:)
                )
            }
        }
    }
}
