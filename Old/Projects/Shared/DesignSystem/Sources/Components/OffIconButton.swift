//
//  OffIconText.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/15/24.
//

import Foundation
import SwiftUI

public struct OffIconButtonView: View {
    public enum Appearance {
        case rounded(icon: OffIcon, title: String, typo: OffTypo)
        case plain(icon: OffIcon, title: String, typo: OffTypo)
    }
    
    let appearance: Appearance
    var onTap: () -> ()
    
    @State var isPressed: Bool = false
    
    public init(appearance: Appearance, isPressed: Bool, onTap: @escaping () -> Void) {
        self.appearance = appearance
        self.isPressed = isPressed
        self.onTap = onTap
    }
    
    public var body: some View {
        switch appearance {
        case let .rounded(icon, title, typo):
            rounded(icon: icon, title: title, typo: typo)
        case let .plain(icon, title, typo):
            plain(icon: icon, title: title, typo: typo)
        }
    }
}

extension OffIconButtonView {
    private func rounded(icon: OffIcon, title: String, typo: OffTypo) -> some View {
        Button(
            action: {
                onTap()
            },
            label: {
                HStack {
                    OffIconView(
                        appearance: .circle(
                            icon: icon,
                            size: .medium,
                            foregroundColor: .init(kind: .grey100),
                            backgroundColor: .init(kind: .grey00)
                        )
                    )

                    Text(title)
                        .font(typo.font)
                    
                    Spacer()
                }
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
        .background(isPressed ? .gray : .clear)
        .scaleEffect(isPressed ? 0.95 : 1)
    }
    
    private func plain(icon: OffIcon, title: String, typo: OffTypo) -> some View {
        Button(
            action: {
                onTap()
            },
            label: {
                HStack {
                    OffIconView(appearance: .plain(icon: icon, size: .small, color: .init(kind: .grey00)))

                    Text(title)
                        .font(typo.font)
                    
                    Spacer()
                }
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
        .padding(20)
        .background(isPressed ? OffColor.init(kind: .grey10).color : OffColor.init(kind: .grey100).color)
        .cornerRadius(15)
        .clipped()
        .scaleEffect(isPressed ? 0.95 : 1)
    }
}
