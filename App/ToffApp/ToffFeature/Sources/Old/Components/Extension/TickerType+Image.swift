//
//  TickerType+Image.swift
//  ToolinderFeatureTradeDemo
//
//  Created by 송영모 on 2023/09/25.
//

import SwiftUI

import ToffDomain

public extension TickerType {
    var systemImageName: String {
        switch self {
        case .stock: return "staroflife.circle.fill"
        case .crypto: return "tornado.circle.fill"
        case .realEstate: return "drop.circle.fill"
        case .gold: return "moon.circle.fill"
        }
    }
    
    var image: Image {
        return .init(systemName: self.systemImageName)
    }
}
