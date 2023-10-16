//
//  RoutineItemCellStore.swift
//  RoffFeatureRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation

import ComposableArchitecture

import RoffDomain

public struct RoutineItemCellStore: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        public let routine: Routine

        public let dateStyle: DateFormatter.Style
        public let timeStyle: DateFormatter.Style
        
        public init(
            id: UUID = .init(),
            routine: Routine,
            dateStyle: DateFormatter.Style,
            timeStyle: DateFormatter.Style
        ) {
            self.id = id
            self.routine = routine
            self.dateStyle = dateStyle
            self.timeStyle = timeStyle
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case tapped
        
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
                
            case .tapped:
                return .send(.delegate(.tapped))
                
            default:
                return .none
            }
        }
    }
}
