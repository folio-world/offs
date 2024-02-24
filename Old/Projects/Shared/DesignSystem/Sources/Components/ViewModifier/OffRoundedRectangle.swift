//
//  OffRoundedRectangle.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/15/24.
//

import Foundation
import SwiftUI

public struct OffRoundedRectangleViewModifier: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .padding(15)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                )
            )
    }
}

public extension View {
    func offRoundedRectangle() -> some View {
        modifier(OffRoundedRectangleViewModifier())
    }
}
