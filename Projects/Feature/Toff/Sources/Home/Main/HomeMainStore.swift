//
//  HomeMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2024/01/20.
//

import Foundation

import ComposableArchitecture

import Domain
import SharedDesignSystem

public struct HomeMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let id: UUID
        
        public init(
            id: UUID = .init()
        ) {
            self.id = id
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        public enum Delegate: Equatable {
            
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}
