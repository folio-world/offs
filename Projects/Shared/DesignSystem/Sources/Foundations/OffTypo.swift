//
//  OffTypo.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/15/24.
//

import Foundation
import SwiftUI

public enum OffTypo {
    case largeTitle
    case title
    case body
    case caption
    case caption2
}

extension OffTypo {
    public var font: SwiftUI.Font {
        return .system(size: self.size, weight: self.weight)
    }
    
    private var size: CGFloat {
        switch self {
        case .largeTitle: return 25
        case .title: return 20
        case .body: return 16
        case .caption: return 10
        case .caption2: return 9
        }
    }
    
    private var weight: SwiftUI.Font.Weight {
        switch self {
        case .largeTitle: return .semibold
        case .title: return .semibold
        case .body: return .regular
        case .caption: return .regular
        case .caption2: return .regular
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
