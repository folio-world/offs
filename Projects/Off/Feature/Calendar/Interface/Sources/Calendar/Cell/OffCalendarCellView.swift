//
//  OffCalendarCellView.swift
//  OffFeatureCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct OffCalendarCellView<T: Equatable>: View {
    private let store: StoreOf<OffCalendarCellStore<T>>
    
    public init(store: StoreOf<OffCalendarCellStore<T>>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 2) {
                HStack {
                    Spacer()
                    
                    Text("\(viewStore.state.date.day)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(viewStore.state.isSelected ? Color.background : Color.foreground)
                    
                    Spacer()
                }
                .padding(.top, 2)
                
                ForEachStore(self.store.scope(state: \.offCalendarPreview, action: OffCalendarCellStore.Action.offCalendarPreview(id:action:))) {
                    OffCalendarPreviewCellView(store: $0)
                }
                
                Spacer()
            }
            .background(viewStore.state.isSelected ? Color.foreground : Color.background)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
            .onTapGesture {
//                viewStore.send(.tapped)
            }
        }
    }
}

