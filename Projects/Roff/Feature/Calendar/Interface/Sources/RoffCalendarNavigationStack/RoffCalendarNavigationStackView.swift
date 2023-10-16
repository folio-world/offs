//
//  RootView.swift
//  DyingFeatureGoalInterface
//
//  Created by 송영모 on 2023/08/03.
//

import SwiftUI

import ComposableArchitecture

import ToffFeatureTradeInterface

public struct ToffCalendarNavigationStackView: View {
    let store: StoreOf<ToffCalendarNavigationStackStore>
    
    public init(store: StoreOf<ToffCalendarNavigationStackStore>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(self.store.scope(
            state: \.path,
            action: ToffCalendarNavigationStackStore.Action.path)
        ) { WithViewStore(self.store, observe: { $0 }) { viewStore in
            ToffCalendarMainView(
                store: self.store.scope(
                    state: \.main,
                    action: ToffCalendarNavigationStackStore.Action.main)
            )
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        } destination: {
            switch $0 {
            case .detail:
                CaseLet(
                    /ToffCalendarNavigationStackStore.Path.State.detail,
                     action: ToffCalendarNavigationStackStore.Path.Action.detail,
                     then: TradeDetailView.init(store:)
                )
            }
        }
    }
}
