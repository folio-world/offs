//
//  PortfolioMainView.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/09/11.
//

import SwiftUI
import Charts

import ComposableArchitecture

import SoffShared

public struct PortfolioMainView: View {
    public let store: StoreOf<PortfolioMainStore>
    
    public init(store: StoreOf<PortfolioMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("Main")
            }
            .navigationTitle("Portfolio")
        }
    }
}

#Preview {
    PortfolioMainView(store: .init(initialState: .init()) {
        PortfolioMainStore()._printChanges()
    })
}
