//
//  StickerView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/15/24.
//

import Foundation
import SwiftUI

public struct OffStickerView: View {
    let title: String
    let color: OffColor
    let typo: OffTypo
    
    public init(color: OffColor, title: String, typo: OffTypo) {
        self.color = color
        self.title = title
        self.typo = typo
    }
    
    public var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(color.color)
                .frame(width: 2.5, height: 11)
            
            Text(title)
                .font(typo.font)
        }
    }
}

#Preview {
    OffStickerView(color: .init(kind: .mint), title: "안녕", typo: .caption)
}
