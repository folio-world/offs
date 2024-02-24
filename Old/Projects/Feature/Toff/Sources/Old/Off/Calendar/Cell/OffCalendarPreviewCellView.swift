//
//  OffCalendarPreviewCellView.swift
//  OffFeatureCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import SwiftUI

import ComposableArchitecture

public struct OffCalendarPreviewCellView: View {
    let store: StoreOf<OffCalendarPreviewCellStore>
    
    public init(store: StoreOf<OffCalendarPreviewCellStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack(spacing: 2) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(viewStore.state.color)
                    .frame(width: 2.5, height: 11)
                
                Text(viewStore.state.title)
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundStyle(viewStore.state.isSelected ? Color.background : Color.foreground)
                
                Spacer()
            }
        }
    }
}
