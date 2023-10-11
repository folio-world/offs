//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import Foundation

import ComposableArchitecture

import OffFeatureCalendarInterface
import ToffDomain

public struct CalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var trades: [Trade]
        public var selectedDate: Date
        public var initialTab: UUID
        public var currentTab: UUID
        
        public var calendars: IdentifiedArrayOf<CalendarStore.State> = []
        public var offCalendars: IdentifiedArrayOf<OffCalendarStore<Trade>.State> = []
        
        public init() {
            let id = UUID()
            
            self.trades = []
            self.selectedDate = .now
            self.initialTab = id
            self.currentTab = id
            self.offCalendars = .init(uniqueElements: [
                makeOffCalendarStoreState(
                    date: .now.add(byAdding: .month, value: -1),
                    trades: []
                ),
                makeOffCalendarStoreState(
                    id: id,
                    date: .now,
                    trades: []
                ),
                makeOffCalendarStoreState(
                    date: .now.add(byAdding: .month, value: 1),
                    trades: []
                ),
            ])
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case selectTab(UUID)
        
        case fetchTradesRequest
        case fetchTradesResponse([Trade])
        case fetched([Trade])
        case refreshCalendar(Date, [Trade])
        
        case calendar(id: CalendarStore.State.ID, action: CalendarStore.Action)
        case offCalendars(id: OffCalendarStore<Trade>.State.ID, action: OffCalendarStore<Trade>.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case detail(Trade)
        }
    }
    
    @Dependency(\.tradeClient) var tradeClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.fetchTradesRequest)
                ])
                
            case let .selectTab(tab):
                state.currentTab = tab
                
                let initialTabIndex = state.offCalendars.index(id: state.initialTab) ?? 0
                let currentTabIndex = state.offCalendars.index(id: tab) ?? 0
                let date = Date.now.add(
                    byAdding: .month,
                    value: currentTabIndex - initialTabIndex
                )
                let calendarStoreState = state.makeOffCalendarStoreState(
                    date: date,
                    trades: state.trades
                )
                
                switch tab {
                case state.offCalendars.ids.first:
                    state.offCalendars.insert(calendarStoreState, at: 0)
                case state.offCalendars.ids.last:
                    state.offCalendars.append(calendarStoreState)
                default: break
                }
                return .none
                
            case let .fetched(trades):
                state.trades = trades
                return .send(.refreshCalendar(state.selectedDate, trades))
                
            case let .refreshCalendar(date, trades):
                if state.calendars.isEmpty {
                    let prevDate = date.add(byAdding: .month, value: -1)
                    let nextDate = date.add(byAdding: .month, value: 1)
                    state.calendars = [
                        .init(
                            offset: -1,
                            calendars: CalendarEntity.toDomain(date: prevDate, trades: trades),
                            selectedDate: prevDate
                        ),
                        .init(
                            offset: 0,
                            calendars: CalendarEntity.toDomain(date: date, trades: trades),
                            selectedDate: .now
                        ),
                        .init(
                            offset: 1,
                            calendars: CalendarEntity.toDomain(date: nextDate, trades: trades),
                            selectedDate: nextDate
                        )
                    ]
                } else {
                    for id in state.calendars.ids {
                        let date = state.calendars[id: id]?.selectedDate ?? .now
                        state.calendars[id: id]?.calendars = CalendarEntity.toDomain(date: date, trades: trades)
                    }
                }
                
                return .none
                
//            case let .calendar(id, action):
//                switch action {
//                case .delegate(.refresh):
//                    return .send(.fetch)
//                    
//                case .editTrade(.presented(.delegate(.save))):
//                    return .send(.fetch)
//                    
//                case .editTrade(.dismiss):
//                    return .send(.fetch)
//                    
//                case let .delegate(.detail(trade)):
//                    return .send(.delegate(.detail(trade)))
//                    
//                default:
//                    return .none
//                }
                
            case let .fetchTradesResponse(trades):
                for id in state.offCalendars.ids {
                    state.offCalendars[id: id]?.offCalendarItems.ids
//                    state.offCalendars[id: id]
                }
                return .none
                
            default:
                return .none
            }
        }
        
        .forEach(\.calendars, action: /Action.calendar(id:action:)) {
            CalendarStore()
        }
    }
}

public extension CalendarMainStore.State {
    func makeOffCalendarStoreState(
        id: UUID = .init(),
        date: Date,
        trades: [Trade]
    ) -> OffCalendarStore<Trade>.State {
        let makeOffCalendarPreviewCellStoreState: (Trade) -> OffCalendarPreviewCellStore.State = { trade in
            return .init(
                title: trade.ticker?.name ?? "",
                color: trade.side == .buy ? .pink : .mint
            )
        }
        
        let makeOffCalendarItemCellState: (Date, [Trade]) -> OffCalendarItemCellStore<Trade>.State = { date, trades in
            return .init(
                date: date,
                isSelected: false,
                makeOffCalendarPreviewCellStoreState: makeOffCalendarPreviewCellStoreState)
        }
        
        return .init(
            id: id,
            selectedDate: date,
            dates: date.allDatesInMonth(),
            data: trades,
            makeOffCalendarItemCellState: makeOffCalendarItemCellState
        )
    }
    
    func updateOffCalendarStoreState(
        offCalendars: IdentifiedArrayOf<OffCalendarStore<Trade>.State>,
        trades: [Trade]
    ) -> IdentifiedArrayOf<OffCalendarStore<Trade>.State> {
        var offCalendars = offCalendars
        for id in offCalendars.ids {
            offCalendars[id: id]?.data = trades
        }
        return offCalendars
    }
}
