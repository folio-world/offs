//
//  RootView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

public struct HomeNavigationStackView: View {
    let store: StoreOf<HomeNavigationStackStore>
    
    public init(store: StoreOf<HomeNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: HomeNavigationStackStore.Action.path)
        ) { WithViewStore(self.store, observe: { $0 }) { viewStore in
            HomeMainView(
                store: self.store.scope(
                    state: \.main,
                    action: HomeNavigationStackStore.Action.main)
            )
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        } destination: {
            switch $0 {
            case .detail:
                CaseLet(
                    /HomeNavigationStackStore.Path.State.detail,
                     action: HomeNavigationStackStore.Path.Action.detail,
                     then: TradeDetailView.init(store:)
                )
            }
        }
    }
}
