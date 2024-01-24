//
//  OffIcon.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 1/15/24.
//

import Foundation
import SwiftUI

import SwiftUI

public struct OffIconView: View {
    public enum Appearance {
        case plain(icon: OffIcon, size: OffIcon.Size, color: OffColor)
        case circle(icon: OffIcon, size: OffIcon.Size, foregroundColor: OffColor, backgroundColor: OffColor)
    }
    
    let appearance: Appearance

    public init(appearance: Appearance) {
        self.appearance = appearance
    }
    
    public var body: some View {
        VStack {
            switch appearance {
            case let .plain(icon: icon, size: size, color: color):
                plain(icon: icon, size: size, color: color)
            case let .circle(icon, size, foregroundColor, backgroundColor):
                circle(icon: icon, size: size, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
            }
        }
    }
    
    private func plain(icon: OffIcon, size: OffIcon.Size, color: OffColor) -> some View {
        Image(systemName: icon.systemImageName)
            .resizable()
            .foregroundStyle(color.color)
            .frame(width: size.rawValue, height: size.rawValue)
    }
    
    private func circle(icon: OffIcon, size: OffIcon.Size, foregroundColor: OffColor, backgroundColor: OffColor) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(backgroundColor.color)
                .frame(width: size.rawValue * 1.5, height: size.rawValue * 1.5)
            
            Image(systemName: icon.systemImageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(foregroundColor.color)
                .frame(width: size.rawValue, height: size.rawValue)
        }
    }
}

public enum OffIcon: String, CaseIterable, Identifiable {
    public var id: String { self.rawValue }
    
    case gearshape
    case plus
    case stock
    case cube
    case globe
}

extension OffIcon {
    public enum Size {
        case large
        case medium
        case small

        public var rawValue: CGFloat {
            switch self {
            case .large: return 32
            case .medium: return 20
            case .small: return 12
            }
        }
    }

    public var systemImageName: String {
        switch self {
        case .plus: return "plus"
        case .stock: return "sun.max.fill"
        case .cube: return "cube.transparent"
        case .globe: return "globe.asia.australia.fill"
        case .gearshape: return "gearshape.fill"
        }
    }
}
