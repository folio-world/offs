//
//  RootView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

import ToffFeatureTradeInterface

public struct RoffCalendarNavigationStackView: View {
    let store: StoreOf<RoffCalendarNavigationStackStore>
    
    public init(store: StoreOf<RoffCalendarNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: RoffCalendarNavigationStackStore.Action.path)
        ) { WithViewStore(self.store, observe: { $0 }) { viewStore in
            ToffCalendarMainView(
                store: self.store.scope(
                    state: \.main,
                    action: RoffCalendarNavigationStackStore.Action.main)
            )
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        } destination: {
            switch $0 {
            case .detail:
                CaseLet(
                    /RoffCalendarNavigationStackStore.Path.State.detail,
                     action: RoffCalendarNavigationStackStore.Path.Action.detail,
                     then: TradeDetailView.init(store:)
                )
            }
        }
    }
}
