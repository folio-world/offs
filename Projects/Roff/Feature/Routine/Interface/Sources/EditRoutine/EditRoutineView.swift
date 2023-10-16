//
//  EditRoutineView.swift
//  RoffFeatureRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import RoffShared

public struct EditRoutineView: View {
    let store: StoreOf<EditRoutineStore>
    
    public init(store: StoreOf<EditRoutineStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                OffEditHeaderView(mode: .add, title: "New Routine") { action in
                    viewStore.send(.editButtonTapped(action))
                }
                
                inputTitleView(title: viewStore.$title)
                
                inputDateView(startDate: viewStore.$startDate, endDate: viewStore.$endDate)
                
                inputTagView(viewStore: viewStore)
                
                inputColorView(color: viewStore.$color)
                
                Spacer()
                
                OffMinimalButton(title: "Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }
            .padding()
        }
    }
    
    private func inputTitleView(title: Binding<String>) -> some View {
        HStack {
            TextField("Title", text: title)
                .font(.title)
        }
    }
    
    private func inputDateView(startDate: Binding<Date>, endDate: Binding<Date>) -> some View {
        HStack {
            Image(systemName: "clock")
            
            Spacer()
            
            DatePicker("", selection: startDate, displayedComponents: .date)
                .fixedSize()
            
            Image(systemName: "chevron.right")
            
            DatePicker("", selection: endDate, displayedComponents: .date)
                .fixedSize()
        }
    }
    
    private func inputTagView(viewStore: ViewStoreOf<EditRoutineStore>) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: .zero) {
                Button("", systemImage: "tag") {
                    viewStore.send(.tagButtonTapped)
                }
                .foregroundStyle(.foreground)
                
                ForEachStore(self.store.scope(state: \.tagItems, action: EditRoutineStore.Action.tagItems(id:action:))) {
                    TagItemCellView(store: $0)
                        .padding(.trailing)
                }
            }
        }
    }
    
    private func inputColorView(color: Binding<Color>) -> some View {
        HStack {
            ColorPicker(selection: color, label: {
                Label("", systemImage: "paintpalette")
            })
            .fixedSize()
            
            Spacer()
        }
    }
}
