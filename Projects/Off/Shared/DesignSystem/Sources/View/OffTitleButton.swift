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
    public var action: () -> ()
    
    public init(
        title: LocalizedStringKey,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "plus")
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
