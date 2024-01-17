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
        case black
        case mint
        case pink
    }
}

extension OffColor.Kind {
    var color: Color {
        switch self {
        case .black: return .black
        case .mint: return .mint
        case .pink: return .pink
        }
    }
}
