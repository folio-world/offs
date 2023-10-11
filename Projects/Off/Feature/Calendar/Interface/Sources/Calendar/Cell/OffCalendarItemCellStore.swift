//
//  OffCalendarCellStore.swift
//  OffFeatureCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation

import ComposableArchitecture

import OffDomain

public struct OffCalendarItemCellStore<T: Equatable>: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        public let date: Date
        public var isSelected: Bool
        
        public let data: [T]
        
        public var offCalendarPreview: IdentifiedArrayOf<OffCalendarPreviewCellStore.State>
        
        public init(
            id: UUID = .init(),
            date: Date,
            isSelected: Bool,
            data: [T] = [],
            makeOffCalendarPreview: @escaping ([T]) -> IdentifiedArrayOf<OffCalendarPreviewCellStore.State>
        ) {
            self.id = id
            self.date = date
            self.isSelected = isSelected
            self.data = data
            self.offCalendarPreview = makeOffCalendarPreview(data)
        }
    }
    
    public indirect enum Action: Equatable {
        case onAppear
        
        case offCalendarPreview(id: OffCalendarPreviewCellStore.State.ID, action: OffCalendarPreviewCellStore.Action)
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
