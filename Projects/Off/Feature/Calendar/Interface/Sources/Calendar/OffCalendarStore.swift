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
    
    public struct State: Equatable {
        public var offCalendars: IdentifiedArrayOf<OffCalendarCellStore<T>.State> = []
        
        public init(offCalendars: IdentifiedArrayOf<OffCalendarCellStore<T>.State>) {
            self.offCalendars = offCalendars
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case offCalendars(id: OffCalendarCellStore<T>.State.ID, action: OffCalendarCellStore<T>.Action)
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
