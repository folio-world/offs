//
//  EditTagView.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/02.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import RoffDomain
import RoffShared

public struct EditTagView: View {
    let store: StoreOf<EditTagStore>
    
    public init(store: StoreOf<EditTagStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                headerView(viewStore: viewStore)
                
                inputNameView(name: viewStore.$name)
                
                inputColorView(color: viewStore.$color)
                
                Spacer()
                
                OffMinimalButton(title: "Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func headerView(viewStore: ViewStoreOf<EditTagStore>) -> some View {
        switch viewStore.state.mode {
        case .add:
            OffEditHeaderView(
                mode: viewStore.state.mode,
                title: "Tag",
                isShowDismissButton: true
            ) { action in
                viewStore.send(.editButtonTapped(action))
            }
        case .edit:
            OffEditHeaderView(
                mode: viewStore.state.mode,
                title: "Tag",
                isShowDeleteButton: true
            ) { action in
                viewStore.send(.editButtonTapped(action))
            }
            
        default: EmptyView()
        }
    }
    
    private func inputNameView(name: Binding<String>) -> some View {
        HStack {
            TextField(
                text: name,
                label: {
                    Label("Name", systemImage: "highlighter")
                }
            )
            .foregroundStyle(.foreground)
        }
    }
    
    private func inputColorView(color: Binding<Color>) -> some View {
        ColorPicker(selection: color, label: {
            Label("Color", systemImage: "paintpalette")
        })
    }
}
