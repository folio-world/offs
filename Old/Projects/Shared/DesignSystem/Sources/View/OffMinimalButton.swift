//
//  MinimalButton.swift
//  FolioSharedDesignSystem
//
//  Created by 송영모 on 2023/09/26.
//

import SwiftUI


public struct OffMinimalButton: View {
    public let title: LocalizedStringKey
    public let isActive: Bool
    
    public var action: () -> ()
    
    public init(
        title: LocalizedStringKey = "",
        isActive: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.isActive = isActive
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Spacer()
                
                Text(self.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.background)
                
                Spacer()
            }
            .padding(.vertical, 10)
        })
        .background(isActive ? Color.foreground : Color.foreground) //TODO: active 현재 미사용
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}
