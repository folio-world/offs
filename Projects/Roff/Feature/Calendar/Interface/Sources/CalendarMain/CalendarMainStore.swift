//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import Foundation

import ComposableArchitecture

public struct CalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
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
