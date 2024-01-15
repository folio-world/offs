//
//  OffIconText.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/15/24.
//

import Foundation
import SwiftUI

public struct OffIconButton: View {
    public enum Appearance {
        case rounded(icon: OffIconView.Appearance, title: String, typo: OffTypo)
    }
    
    let appearance: Appearance
    
    public var body: some View {
        switch appearance {
        case let .rounded(icon, title, typo):
            plain(icon: icon, title: title, typo: typo)
        }
    }
}

extension OffIconButton {
    private func plain(icon: OffIconView.Appearance, title: String, typo: OffTypo) -> some View {
        HStack {
            OffIconView(appearance: icon)
            Spacer()
            Text(title)
                .font(typo.font)
        }
        .offRoundedRectangle()
    }
}
