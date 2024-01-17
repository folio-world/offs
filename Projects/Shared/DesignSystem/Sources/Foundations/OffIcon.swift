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
        case circle(icon: OffIcon, size: OffIcon.Size, color: OffColor)
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
            case let .circle(icon: icon, size: size, color: color):
                circle(icon: icon, size: size, color: color)
            }
        }
    }
    
    private func plain(icon: OffIcon, size: OffIcon.Size, color: OffColor) -> some View {
        Image(systemName: icon.systemImageName)
            .resizable()
            .foregroundStyle(color.color)
            .frame(width: size.rawValue, height: size.rawValue)
    }
    
    private func circle(icon: OffIcon, size: OffIcon.Size, color: OffColor) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(color.withOpacity(0.1).color)
                .frame(width: size.rawValue * 1.5, height: size.rawValue * 1.5)
            
            Image(systemName: icon.systemImageName)
                .resizable()
                .foregroundStyle(color.color)
                .frame(width: size.rawValue, height: size.rawValue)
        }
    }
}

public enum OffIcon: String, CaseIterable, Identifiable {
    public var id: String { self.rawValue }
    
    case stock
    case cube
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
        case .stock: return "chart.line.uptrend.xyaxis"
        case .cube: return "cube.transparent"
        }
    }
    
    public var defaultColor: OffColor {
        switch self {
        case .stock: return .init(kind: .pink)
        case .cube: return .init(kind: .pink)
        }
    }
}
