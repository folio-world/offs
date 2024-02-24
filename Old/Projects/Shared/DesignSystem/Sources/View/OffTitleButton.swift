//
//  OffNewButton.swift
//  OffSharedDesignSystem
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftUI

public struct OffTitleButton: View {
    let title: LocalizedStringKey
    let systemName: String
    public var action: () -> ()
    
    public init(
        title: LocalizedStringKey = "",
        systemName: String = "plus",
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemName = systemName
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemName)
                .font(.headline)

            Text(title)
            
            Spacer()
        }
        .offMinimalBackgroundStyle()
        .onTapGesture {
            action()
        }
    }
}
