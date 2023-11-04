//
//  ImageNewItem.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/09/16.
//

import SwiftUI

public struct ImageNewItem: View {
    public var body: some View {
        VStack {
            Image(systemName: "plus")
        }
        .foregroundStyle(.foreground)
        .frame(width: 48, height: 48)
        .background(.ultraThickMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
