//
//  OffMinimalBackground.swift
//  OffSharedDesignSystem
//
//  Created by 송영모 on 10/16/23.
//

import SwiftUI

public struct OffMinimalBackground: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .padding(10)
            .background(Color(uiColor: .systemGray6))
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
    }
}

public extension View {
    func offMinimalBackgroundStyle() -> some View {
        modifier(OffMinimalBackground())
    }
}
