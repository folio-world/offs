//
//  OffCalendarStore.swift
//  OffFeatureCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation

import ComposableArchitecture

public struct OffCalendarStore<T: Equatable>: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        public var offCalendarItems: IdentifiedArrayOf<OffCalendarItemCellStore<T>.State> = []
        
        public init(
            id: UUID = .init(),
            offCalendarItems: IdentifiedArrayOf<OffCalendarItemCellStore<T>.State>
        ) {
            self.id = id
            self.offCalendarItems = offCalendarItems
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case offCalendarItems(id: OffCalendarItemCellStore<T>.State.ID, action: OffCalendarItemCellStore<T>.Action)
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
