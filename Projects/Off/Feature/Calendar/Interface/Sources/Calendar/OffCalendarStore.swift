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
        public static func == (lhs: OffCalendarStore<T>.State, rhs: OffCalendarStore<T>.State) -> Bool {
            lhs.id == rhs.id
        }
        public let id: UUID
        public var selectedDate: Date
        public var dates: [Date]
        public var data: [T] {
            didSet {
                self.offCalendarItems =  makeOffCalendarItems(dates: dates, data: data)
            }
        }
        public let makeOffCalendarItemCellState: (Date, [T]) -> OffCalendarItemCellStore<T>.State
        
        public var offCalendarItems: IdentifiedArrayOf<OffCalendarItemCellStore<T>.State> = []
        
        public init(
            id: UUID = .init(),
            selectedDate: Date,
            dates: [Date],
            data: [T],
            makeOffCalendarItemCellState: @escaping (Date, [T]) -> OffCalendarItemCellStore<T>.State
        ) {
            self.id = id
            self.selectedDate = selectedDate
            self.dates = dates
            self.data = data
            self.makeOffCalendarItemCellState = makeOffCalendarItemCellState
            self.offCalendarItems = makeOffCalendarItems(dates: dates, data: data)
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

public extension OffCalendarStore.State {
    func makeOffCalendarItems(dates: [Date], data: [T]) -> IdentifiedArrayOf<OffCalendarItemCellStore<T>.State> {
        return .init(
            uniqueElements: dates.map { date in
                self.makeOffCalendarItemCellState(date, data)
            }
        )
    }
}
