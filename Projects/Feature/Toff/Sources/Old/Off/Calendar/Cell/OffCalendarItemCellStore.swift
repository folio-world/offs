//
//  OffCalendarCellStore.swift
//  OffFeatureCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation

import ComposableArchitecture

import ToffDomain

public struct OffCalendarItemCellStore<T: Equatable>: Reducer {
    public init() {}
    
    public struct State: Equatable, Identifiable {
        public let id: UUID
        public let date: Date
        public var isSelected: Bool {
            didSet {
                self.offCalendarPreviews = self.updateOffCalendarPreviews(offCalendarPreviews: offCalendarPreviews, isSelected: isSelected)
            }
        }
        
        public let data: [T]
        
        public var offCalendarPreviews: IdentifiedArrayOf<OffCalendarPreviewCellStore.State>
        
        public init(
            id: UUID = .init(),
            date: Date,
            isSelected: Bool,
            data: [T] = [],
            makeOffCalendarPreviewCellStoreState: @escaping (T) -> OffCalendarPreviewCellStore.State
        ) {
            self.id = id
            self.date = date
            self.isSelected = isSelected
            self.data = data
            self.offCalendarPreviews = .init(
                uniqueElements: data.map { makeOffCalendarPreviewCellStoreState($0) }
            )
        }
    }
    
    public indirect enum Action: Equatable {
        case onAppear
        
        case tapped
        
        case offCalendarPreviews(id: OffCalendarPreviewCellStore.State.ID, action: OffCalendarPreviewCellStore.Action)
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

public extension OffCalendarItemCellStore.State {
    func updateOffCalendarPreviews(
        offCalendarPreviews: IdentifiedArrayOf<OffCalendarPreviewCellStore.State>,
        isSelected: Bool
    ) -> IdentifiedArrayOf<OffCalendarPreviewCellStore.State> {
        var newOffCalendarPreviews = offCalendarPreviews
        for id in offCalendarPreviews.ids {
            newOffCalendarPreviews[id: id]?.isSelected = isSelected
        }
        return newOffCalendarPreviews
    }
}
