//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import Foundation

import ComposableArchitecture

import OffFeatureCalendarInterface
import ToffFeatureTradeInterface
import ToffDomain

public struct ToffCalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let id: UUID
        public var trades: [Trade]
        public var currentTab: UUID
        
        public var headerDate: Date
        public var selectedDate: Date {
            didSet {
                self.tradeItems = self.makeTradeItems(from: trades.filter({ $0.date.isEqual(date: selectedDate) }))
            }
        }
        
        public var offCalendars: IdentifiedArrayOf<OffCalendarStore<Trade>.State> = []
        public var tradeItems: IdentifiedArrayOf<TradeItemCellStore.State> = []
        
        public init(
            id: UUID = .init(),
            trades: [Trade] = [],
            initialDate: Date = .now
        ) {
            self.id = id
            self.trades = trades
            self.selectedDate = initialDate
            self.headerDate = initialDate
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
        
        case offCalendars(id: OffCalendarStore<Trade>.State.ID, action: OffCalendarStore<Trade>.Action)
        case tradeItems(id: TradeItemCellStore.State.ID, action: TradeItemCellStore.Action)
        
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
                    trades: state.trades
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
                
//            case let .offCalendars(id: id, action: .delegate(.tapped)):
//                return .none
                
            case .fetchTradesRequest:
                if let trades = try? tradeClient.fetchTrades().get() {
                    return .send(.fetchTradesResponse(trades))
                }
                return .none
                
            case let .fetchTradesResponse(trades):
                state.offCalendars = state.updateOffCalendars(
                    offCalendars: state.offCalendars,
                    trades: trades
                )
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
        .forEach(\.tradeItems, action: /Action.tradeItems(id:action:)) {
            TradeItemCellStore()
        }
    }
}

public extension ToffCalendarMainStore.State {
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
            initialDate: date,
            data: trades,
            makeOffCalendarItemCellState: makeOffCalendarItemCellState
        )
    }
    
    func updateOffCalendars(
        offCalendars: IdentifiedArrayOf<OffCalendarStore<Trade>.State>,
        trades: [Trade]
    ) -> IdentifiedArrayOf<OffCalendarStore<Trade>.State> {
        var offCalendars = offCalendars
        for id in offCalendars.ids {
            offCalendars[id: id]?.data = trades
        }
        return offCalendars
    }
    
    func makeTradeItems(from trades: [Trade]) -> IdentifiedArrayOf<TradeItemCellStore.State> {
        return .init(
            uniqueElements: trades.map { trade in
                return .init(trade: trade, dateStyle: .short, timeStyle: .short)
            }
        )
    }
}
