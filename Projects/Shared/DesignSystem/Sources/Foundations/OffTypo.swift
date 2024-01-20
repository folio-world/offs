//
//  OffTypo.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/15/24.
//

import Foundation
import SwiftUI

public enum OffTypo {
    case title
    case body
    case caption
}

extension OffTypo {
    public var font: SwiftUI.Font {
        return .system(size: self.size, weight: self.weight)
    }
    
    private var size: CGFloat {
        switch self {
        case .title: return 20
        case .body: return 16
        case .caption: return 10
        }
    }
    
    private var weight: SwiftUI.Font.Weight {
        switch self {
        case .title: return .bold
        case .body: return .regular
        case .caption: return .regular
        }
    }
}

public struct OffTypoViewModifier: ViewModifier {
    let typo: OffTypo
    
    public func body(content: Content) -> some View {
        content
            .font(typo.font)
    }
}

public extension View {
    func offTypo(_ typo: OffTypo) -> some View {
        self.modifier(OffTypoViewModifier(typo: typo))
    }
}
