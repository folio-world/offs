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
        public let dates: [Date]
        public var selectedDate: Date {
            didSet {
                self.offCalendarItems = updateOffCalendarItems(offCalendarItems: offCalendarItems, selectedDate: selectedDate)
            }
        }
        public var data: [T] {
            didSet {
                self.offCalendarItems =  makeOffCalendarItems(dates: dates, data: data)
            }
        }
        public let makeOffCalendarItemCellState: (Date, [T]) -> OffCalendarItemCellStore<T>.State
        
        public var offCalendarItems: IdentifiedArrayOf<OffCalendarItemCellStore<T>.State> = []
        
        public init(
            id: UUID = .init(),
            dates: [Date],
            selectedDate: Date,
            data: [T],
            makeOffCalendarItemCellState: @escaping (Date, [T]) -> OffCalendarItemCellStore<T>.State
        ) {
            self.id = id
            self.dates = dates
            self.selectedDate = selectedDate
            self.data = data
            self.makeOffCalendarItemCellState = makeOffCalendarItemCellState
            self.offCalendarItems = makeOffCalendarItems(dates: dates, data: data)
        }
        
        public static func == (lhs: OffCalendarStore<T>.State, rhs: OffCalendarStore<T>.State) -> Bool {
            lhs.id == rhs.id
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
                
            case let .offCalendarItems(id: id, action: .delegate(.tapped)):
                state.selectedDate = state.offCalendarItems[id: id]?.date ?? .now
                print("[D] hi")
                return .send(.delegate(.tapped))
                
            default:
                return .none
            }
        }
        
        .forEach(\.offCalendarItems, action: /Action.offCalendarItems(id:action:)) {
            OffCalendarItemCellStore()
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
    
    func updateOffCalendarItems(
        offCalendarItems: IdentifiedArrayOf<OffCalendarItemCellStore<T>.State>,
        selectedDate: Date
    ) -> IdentifiedArrayOf<OffCalendarItemCellStore<T>.State> {
        var newOffCalendarItems = offCalendarItems
        for id in offCalendarItems.ids {
            newOffCalendarItems[id: id]?.isSelected = selectedDate.isEqual(date: offCalendarItems[id: id]?.date ?? .now)
        }
        return newOffCalendarItems
    }
}
