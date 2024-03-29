//
//  AddPriceView.swift
//  ToolinderFeatureCalendarDemo
//
//  Created by 송영모 on 2023/09/08.
//

import SwiftUI
import SwiftData
import PhotosUI

import ComposableArchitecture

import ToffDomain
import OffShared
import OffSharedDesignSystem

public struct EditTradeView: View {
    let store: StoreOf<EditTradeStore>
    
    public init(store: StoreOf<EditTradeStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                headerView(viewStore: viewStore)
                
                pickerView(viewStore: viewStore)
                
                inputView(viewStore: viewStore)
                
                Spacer()
                
                OffMinimalButton(title: "Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }
            .alert(
                store: self.store.scope(
                    state: \.$alert,
                    action: { .alert($0) }
                )
            )
            .padding()
        }
    }
    
    private func headerView(viewStore: ViewStoreOf<EditTradeStore>) -> some View {
        HStack {
            if viewStore.state.mode == .add {
                Button(action: {
                    viewStore.send(.dismissButtonTapped)
                }, label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundStyle(.foreground)
                })
            }
            
            Text(viewStore.state.selectedTicker.name)
                .font(.title)
            
            Spacer()
            
            if viewStore.state.mode == .edit {
                Button(action: {
                    viewStore.send(.deleteButtonTapped)
                }, label: {
                    Image(systemName: "trash.circle.fill")
                        .foregroundStyle(.foreground)
                        .font(.title)
                })
            }
        }
    }
    
    private func pickerView(viewStore: ViewStoreOf<EditTradeStore>) -> some View {
        HStack {
            Picker("", selection: viewStore.binding(get: \.selectedTradeSide, send: EditTradeStore.Action.selectTradeSide)) {
                ForEach(TradeSide.allCases, id: \.self) { tradeSide in
                    Text(tradeSide.rawValue)
                        .tag(tradeSide)
                }
            }
            .pickerStyle(.segmented)
            
            DatePicker("", selection: viewStore.binding(get: \.selectedDate, send: EditTradeStore.Action.selectDate))
        }
    }
    
    private func inputView(viewStore: ViewStoreOf<EditTradeStore>) -> some View {
        VStack(spacing: 20) {
            HStack {
                viewStore.state.selectedTicker.currency.image
                
                TextField("Price", value: viewStore.binding(get: \.price, send: EditTradeStore.Action.setPrice), format: .number)
                    .keyboardType(.decimalPad)
                
                Image(systemName: "plusminus.circle.fill")
                
                TextField("Volume", value: viewStore.binding(get: \.quantity, send: EditTradeStore.Action.setQuantity), format: .number)
                    .keyboardType(.decimalPad)
                
                Image(systemName: "building.columns.circle.fill")
                
                TextField("Fee %", value: viewStore.binding(get: \.fee, send: EditTradeStore.Action.setFee), format: .number)
                    .keyboardType(.decimalPad)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                Image(systemName: "note.text")
                
                TextEditor(text: viewStore.binding(get: \.note, send: EditTradeStore.Action.setNote))
            }
            
            ScrollView(.horizontal) {
                HStack {
                    Image(systemName: "photo")
                    
                    ForEach(viewStore.state.images, id: \.self) { imageData in
                        ImageItem(imageData: imageData)
                    }
                    
                    PhotosPicker(selection: viewStore.binding(get: \.selectedPhotosPickerItems, send: EditTradeStore.Action.setPhotoPickerItems),
                                 matching: .images) {
                        ImageNewItem()
                    }
                }
            }
        }
    }
}
