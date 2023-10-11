//
//  OffCalendarView.swift
//  OffFeatureCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct OffCalendarView<T: Equatable>: View {
    let store: StoreOf<OffCalendarStore<T>>
    
    public init(store: StoreOf<OffCalendarStore<T>>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            GeometryReader { proxy in
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
                    ForEachStore(self.store.scope(state: \.offCalendarItems, action: OffCalendarStore.Action.offCalendarItems(id:action:))) {
                        OffCalendarItemCellView(store: $0)
                            .frame(height: proxy.size.height * 0.12)
                    }
                    Spacer()
                }
            }
            .tag(viewStore.id)
        }
    }
}
