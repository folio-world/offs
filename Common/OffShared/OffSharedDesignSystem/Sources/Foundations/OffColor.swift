//
//  OffColor.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/15/24.
//

import SwiftUI

public struct OffColor: Equatable, Hashable {
    public let kind: Kind
    public var opacity: Double

    public init(kind: Kind, opacity: Double = 1.0) {
        self.kind = kind
        self.opacity = opacity
    }

    public func withOpacity(_ opacity: Double) -> Self {
        OffColor(kind: self.kind, opacity: opacity)
    }

    public var color: Color {
        kind.color.opacity(opacity)
    }
}

extension OffColor {
    public enum Kind {
        case grey00
        case grey10
        case grey25
        case grey50
        case grey75
        case grey100
        case red
        case blue
    }
}

extension OffColor.Kind {
    var color: Color {
        switch self {
        case .grey00: return Color("grey00", bundle: Bundle.module)
        case .grey10: return Color("grey10", bundle: Bundle.module)
        case .grey25: return Color("grey25", bundle: Bundle.module)
        case .grey50: return Color("grey50", bundle: Bundle.module)
        case .grey75: return Color("grey75", bundle: Bundle.module)
        case .grey100: return Color("grey100", bundle: Bundle.module)
        case .red: return Color("red", bundle: Bundle.module)
        case .blue: return Color("blue", bundle: Bundle.module)
        }
    }
}
