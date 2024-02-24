//
//  OffAnimatedSelected.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/26/24.
//

import Foundation
import SwiftUI

public struct OffAnimatedSelectedViewModifier: ViewModifier {
    @Binding var isSelected: Bool {
        didSet {
            withAnimation {
                self.isPressed = $isSelected.wrappedValue
            }
        }
    }
    var onTap: () -> Void
    
    @State private var isPressed: Bool
    
    init(isSelected: Binding<Bool>, onTap: @escaping () -> Void) {
        self._isSelected = isSelected
        self.isPressed = isSelected.wrappedValue
        self.onTap = onTap
    }

    public func body(content: Content) -> some View {
        Button(
            action: { onTap() },
            label: {
                content
                    .contentShape(.rect)
            }
        )
        .buttonStyle(
            ScrollViewGestureButtonStyle(
                pressAction: { onTap() },
                doubleTapTimeoutout: 1,
                doubleTapAction: { },
                longPressTime: 0,
                longPressAction: { },
                endAction: { }))
        .padding(15)
        .background(isPressed ? OffColor.init(kind: .grey10).color : OffColor.init(kind: .grey100).color)
        .cornerRadius(15)
        .clipped()
        .scaleEffect(isPressed ? 0.95 : 1)
    }
}

public extension View {
    func offAnimatedSelected(isSelected: Binding<Bool>, onTap: @escaping  () -> Void) -> some View {
        self.modifier(OffAnimatedSelectedViewModifier(isSelected: isSelected, onTap: onTap))
    }
}
