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
        case let .plain(icon, title, typo):
            plain(icon: icon, title: title, typo: typo)
        }
    }
}

extension OffIconButtonView {
    private func plain(icon: OffIcon, title: String, typo: OffTypo) -> some View {
        Button(
            action: {
                onTap()
            },
            label: {
                OffIconView(appearance: .circle(icon: icon, size: .medium, color: icon.defaultColor))
                Spacer()
                Text(title)
                    .font(typo.font)
                    .offRoundedRectangle()
                    .buttonStyle(
                        ScrollViewGestureButtonStyle(
                            pressAction: { withAnimation { isPressed = true } },
                            doubleTapTimeoutout: 1,
                            doubleTapAction: { },
                            longPressTime: 0,
                            longPressAction: { },
                            endAction: { withAnimation { isPressed = false } }))
            })
    }
}
    
    //import Foundation
    //import SwiftUI
    //
    //struct D3NIconAnimationButton: View {
    //    let icon: D3NIcon?
    //    let title: String
    //    let content: String
    //
    //    var action: () -> ()
    //
    //    var isSelected: Bool = false
    //    @State var isPressed: Bool = false
    //
    //    init(
    //        icon: D3NIcon? = nil,
    //        title: String = "",
    //        content: String = "",
    //        isSelected: Bool = false,
    //
    //        action: @escaping () -> ()
    //    ) {
    //        self.icon = icon
    //        self.title = title
    //        self.content = content
    //        self.isSelected = isSelected
    ////        self.isPressed = isSelected
    //
    //        self.action = action
    //    }
    //
    //    var body: some View {
    //        Button(action: {
    //            action()
    //        }, label: {
    //            HStack {
    //                self.icon
    //
    //                VStack(alignment: .leading, spacing: 5) {
    //                    if !title.isEmpty {
    //                        Text(title)
    //                            .fontWeight(.semibold)
    //                    }
    //                    if !content.isEmpty {
    //                        Text(content)
    //                            .font(.footnote)
    //                            .foregroundStyle(.gray)
    //                            .lineLimit(1)
    //                    }
    //                }
    //
    //                Spacer()
    //            }
    //            .contentShape(.rect)
    //        })
    //        .buttonStyle(
    //            ScrollViewGestureButtonStyle(
    //                pressAction: {
    //                    withAnimation {
    //                        isPressed = true
    //                    }
    //                },
    //                doubleTapTimeoutout: 1,
    //                doubleTapAction: {
    //                },
    //                longPressTime: 0,
    //                longPressAction: {
    //                },
    //                endAction: {
    //                    withAnimation {
    //                        isPressed = false
    //                    }
    //                }
    //            )
    //        )
    //        .padding(10)
    //        .background(isSelected ? Color.systemGray6 : Color.background)
    //        .cornerRadius(20)
    //        .clipped()
    //        .scaleEffect(isSelected ? 0.95 : 1)
    //    }
    //}
    //
