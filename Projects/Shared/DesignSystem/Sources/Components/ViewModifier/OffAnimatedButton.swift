//
//  OffAnimatedButton.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/20/24.
//

import Foundation
import SwiftUI

public struct OffAnimatedButtonViewModifier: ViewModifier {
    
    @State var isPressed: Bool = false
    var onTap: () -> ()
    
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
                pressAction: { withAnimation { isPressed = true } },
                doubleTapTimeoutout: 1,
                doubleTapAction: { },
                longPressTime: 0,
                longPressAction: { },
                endAction: { withAnimation { isPressed = false } }))
        .padding(15)
        .background(isPressed ? OffColor.init(kind: .grey10).color : OffColor.init(kind: .grey100).color)
        .cornerRadius(15)
        .clipped()
        .scaleEffect(isPressed ? 0.95 : 1)
    }
}

public extension View {
    func offAnimatedButton(onTap: @escaping  () -> ()) -> some View {
        self.modifier(OffAnimatedButtonViewModifier(onTap: onTap))
    }
}
