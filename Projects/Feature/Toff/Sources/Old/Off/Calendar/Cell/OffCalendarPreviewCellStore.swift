//
//  OffCalendarPreviewCellStore.swift
//  OffFeatureCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import Domain

public struct OffCalendarPreviewCellStore: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        public let title: String
        public let color: Color
        public var isSelected: Bool
        
        public init(
            id: UUID = .init(),
            title: String,
            color: Color,
            isSelected: Bool = false
        ) {
            self.id = id
            self.title = title
            self.color = color
            self.isSelected = isSelected
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case tapped
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
    }
}
