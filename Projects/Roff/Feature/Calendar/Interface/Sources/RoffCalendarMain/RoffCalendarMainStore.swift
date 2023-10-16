//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import Foundation

import ComposableArchitecture

import OffFeatureCalendarInterface
import RoffFeatureRoutineInterface
import RoffDomain

public struct RoffCalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let id: UUID
        public var routines: [Routine]
        public var currentTab: UUID
        
        public var headerDate: Date
        public var selectedDate: Date {
            didSet {
//                self.tradeItems = self.makeTradeItems(from: trades.filter({ $0.date.isEqual(date: selectedDate) }))
            }
        }
        
        public var offCalendars: IdentifiedArrayOf<OffCalendarStore<Routine>.State> = []
//        public var tradeItems: IdentifiedArrayOf<TradeItemCellStore.State> = []
//        @PresentationState var selectTicker: SelectTickerStore.State?
//        @PresentationState var editTrade: EditTradeStore.State?
        
        public init(
            id: UUID = .init(),
            routines: [Routine] = [],
            initialDate: Date = .now
        ) {
            self.id = id
            self.routines = routines
            self.selectedDate = initialDate
            self.headerDate = initialDate
            self.currentTab = id
            self.offCalendars = .init(uniqueElements: [
                makeOffCalendarStoreState(
                    date: .now.add(byAdding: .month, value: -1),
                    routines: []
                ),
                makeOffCalendarStoreState(
                    id: id,
                    date: .now,
                    routines: []
                ),
                makeOffCalendarStoreState(
                    date: .now.add(byAdding: .month, value: 1),
                    routines: []
                ),
            ])
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case selectTab(UUID)
        case newButtonTapped
        
        case fetchRoutinesRequest
        case fetchRoutinesResponse([Routine])
        
        case offCalendars(id: OffCalendarStore<Routine>.State.ID, action: OffCalendarStore<Routine>.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case detail(Routine)
        }
    }
    
    @Dependency(\.routineClient) var routineClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchRoutinesRequest)
                ])
                
            case let .selectTab(tab):
                let initialTabIndex = state.offCalendars.index(id: state.id) ?? 0
                let currentTabIndex = state.offCalendars.index(id: tab) ?? 0
                let offset = currentTabIndex - initialTabIndex
                let addMonthValue = currentTabIndex > initialTabIndex ? offset + 1 : offset - 1
                
                let date = Date.now.add(
                    byAdding: .month,
                    value: addMonthValue
                )
                let calendarStoreState = state.makeOffCalendarStoreState(
                    date: date,
                    routines: state.routines
                )
                
                switch tab {
                case state.offCalendars.ids.first:
                    state.offCalendars.insert(calendarStoreState, at: 0)
                case state.offCalendars.ids.last:
                    state.offCalendars.append(calendarStoreState)
                default: break
                }
                
                state.currentTab = tab
                state.selectedDate = state.offCalendars[id: tab]?.selectedDate ?? .now
                state.headerDate = state.offCalendars[id: tab]?.initialDate ?? .now
                return .none
                
            case .newButtonTapped:
//                state.selectTicker = .init()
                return .none
                
            case .fetchRoutinesRequest:
                let routines = routineClient.fetchRoutines()
                return .send(.fetchRoutinesResponse(routines))
                
            case let .fetchRoutinesResponse(routines):
                state.routines = routines
                state.offCalendars = state.updateOffCalendars(
                    offCalendars: state.offCalendars,
                    routines: routines
                )
//                state.tradeItems = state.makeTradeItems(
//                    from: trades.filter({ $0.date.isEqual(date: state.selectedDate) })
//                )
                return .none
                
            case let .offCalendars(id: _, action: .delegate(.tapped(date))):
                state.selectedDate = date
                return .none
                
            default:
                return .none
            }
        }
        .forEach(\.offCalendars, action: /Action.offCalendars(id:action:)) {
            OffCalendarStore()
        }
    }
}

public extension RoffCalendarMainStore.State {
    func makeOffCalendarStoreState(
        id: UUID = .init(),
        date: Date,
        routines: [Routine]
    ) -> OffCalendarStore<Routine>.State {
        let makeOffCalendarPreviewCellStoreState: (Routine) -> OffCalendarPreviewCellStore.State = { routine in
            return .init(
                title: routine.title,
                color: .pink
            )
        }
        let makeOffCalendarItemCellState: (Date, [Routine]) -> OffCalendarItemCellStore<Routine>.State = { date, routines in
            return .init(
                date: date,
                isSelected: false,
                data: routines,
                makeOffCalendarPreviewCellStoreState: makeOffCalendarPreviewCellStoreState
            )
        }
        
        return .init(
            id: id,
            initialDate: date,
            data: routines,
            makeOffCalendarItemCellState: makeOffCalendarItemCellState
        )
    }
    
    func updateOffCalendars(
        offCalendars: IdentifiedArrayOf<OffCalendarStore<Routine>.State>,
        routines: [Routine]
    ) -> IdentifiedArrayOf<OffCalendarStore<Routine>.State> {
        var offCalendars = offCalendars
        for id in offCalendars.ids {
            offCalendars[id: id]?.data = routines
        }
        return offCalendars
    }
    
//    func makeTradeItems(from trades: [Trade]) -> IdentifiedArrayOf<TradeItemCellStore.State> {
//        return .init(
//            uniqueElements: trades.map { trade in
//                return .init(trade: trade, dateStyle: .short, timeStyle: .short)
//            }
//        )
//    }
}
