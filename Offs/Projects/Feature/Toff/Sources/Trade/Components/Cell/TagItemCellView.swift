//
//  TagItemCellView.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import SwiftUI

import ComposableArchitecture

import Domain
import Shared

public struct TagItemCellView: View {
    private let store: StoreOf<TagItemCellStore>
    
    public init(store: StoreOf<TagItemCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 10) {
                Circle()
                    .fill(Color(hex: viewStore.state.tag.hex))
                    .frame(width: 15, height: 15)
                
                Text(viewStore.state.tag.name)
                    .font(.caption2)
                    .foregroundStyle(.foreground)
                
                if viewStore.state.mode == .edit {
                    Button(action: {
                        viewStore.send(.editButtonTapped)
                    }, label: {
                        Image(systemName: "pencil.circle.fill")
                    })
                    .foregroundStyle(.foreground)
                }
            }
            .padding(10)
            .background(.ultraThickMaterial)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(viewStore.state.isSelected ? Color.foreground : Color.clear, lineWidth: 1)
            )
            .onTapGesture {
                viewStore.send(.tapped)
            }
        }
    }
}
