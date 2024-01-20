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
    }
}

extension OffColor.Kind {
    var color: Color {
        switch self {
        case .grey00: return SharedDesignSystemAsset.grey00.swiftUIColor
        case .grey10: return SharedDesignSystemAsset.grey10.swiftUIColor
        case .grey25: return SharedDesignSystemAsset.grey25.swiftUIColor
        case .grey50: return SharedDesignSystemAsset.grey50.swiftUIColor
        case .grey75: return SharedDesignSystemAsset.grey75.swiftUIColor
        case .grey100: return SharedDesignSystemAsset.grey100.swiftUIColor
        }
    }
}
