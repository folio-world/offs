//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import Foundation

import ComposableArchitecture

import Domain
import SharedDesignSystem

public struct ToffCalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let id: UUID
        public var trades: [Trade]
        
        public var prevCalendarItems: [TradeCalendarItem] = []
        public var currentCalendarItems: [TradeCalendarItem] = []
        public var nextCalendarItems: [TradeCalendarItem] = []
        
        public var currentTab: UUID
        
        public var headerDate: Date
        public var selectedDate: Date {
            didSet {
                self.tradeItems = self.makeTradeItems(from: trades.filter({ $0.date.isEqual(date: selectedDate) }))
            }
        }

        public var tradeItems: IdentifiedArrayOf<TradeItemCellStore.State> = []
        @PresentationState var selectTicker: SelectTickerStore.State?
        @PresentationState var editTrade: EditTradeStore.State?
        
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
//            self.offCalendars = .init(uniqueElements: [
//                makeOffCalendarStoreState(
//                    date: .now.add(byAdding: .month, value: -1),
//                    trades: []
//                ),
//                makeOffCalendarStoreState(
//                    id: id,
//                    date: .now,
//                    trades: []
//                ),
//                makeOffCalendarStoreState(
//                    date: .now.add(byAdding: .month, value: 1),
//                    trades: []
//                ),
//            ])
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case selectTab(UUID)
        case newButtonTapped
        
        case fetchTradesRequest
        case fetchTradesResponse([Trade])
        
//        case offCalendars(id: OffCalendarStore<Trade>.State.ID, action: OffCalendarStore<Trade>.Action)
        case tradeItems(id: TradeItemCellStore.State.ID, action: TradeItemCellStore.Action)
        case selectTicker(PresentationAction<SelectTickerStore.Action>)
        case editTrade(PresentationAction<EditTradeStore.Action>)
        
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
                let initialTabIndex = 0
                let currentTabIndex = 0
                let offset = currentTabIndex - initialTabIndex
                let addMonthValue = currentTabIndex > initialTabIndex ? offset + 1 : offset - 1
                
                let date = Date.now.add(
                    byAdding: .month,
                    value: addMonthValue
                )
//                let calendarStoreState = state.makeOffCalendarStoreState(
//                    date: date,
//                    trades: state.trades
//                )
                
//                switch tab {
//                case state.offCalendars.ids.first:
//                    state.offCalendars.insert(calendarStoreState, at: 0)
//                case state.offCalendars.ids.last:
//                    state.offCalendars.append(calendarStoreState)
//                default: break
//                }
                
                state.currentTab = tab
//                state.selectedDate = state.offCalendars[id: tab]?.selectedDate ?? .now
//                state.headerDate = state.offCalendars[id: tab]?.initialDate ?? .now
                return .none
                
            case .newButtonTapped:
                state.selectTicker = .init()
                return .none
                
            case .fetchTradesRequest:
                if let trades = try? tradeClient.fetchTrades().get() {
                    return .send(.fetchTradesResponse(trades))
                }
                return .none
                
            case let .fetchTradesResponse(trades):
                state.trades = trades
//                state.offCalendars = state.updateOffCalendars(
//                    offCalendars: state.offCalendars,
//                    trades: trades
//                )
                state.tradeItems = state.makeTradeItems(
                    from: trades.filter({ $0.date.isEqual(date: state.selectedDate) })
                )
                return .none
                
//            case let .offCalendars(id: _, action: .delegate(.tapped(date))):
//                state.selectedDate = date
//                return .none
                
            case let .tradeItems(id: id, action: .delegate(.tapped)):
                if let trade = state.tradeItems[id: id]?.trade {
                    return .send(.delegate(.detail(trade)))
                }
                return .none
                
            case let .selectTicker(.presented(.delegate(.select(ticker)))):
                state.selectTicker = nil
                state.editTrade = .init(selectedTicker: ticker, selectedDate: state.selectedDate)
                return .none
                
            case .selectTicker(.dismiss):
                state.selectTicker = nil
                return .none
                
            case let .editTrade(.presented(.delegate(.cancel(ticker)))):
                state.selectTicker = .init(selectedTicker: ticker)
                state.editTrade = nil
                return .none
                
            case .editTrade(.presented(.delegate(.save))):
                state.selectTicker = nil
                state.editTrade = nil
                return .send(.fetchTradesRequest)
                
            case .editTrade(.dismiss):
                state.editTrade = nil
                return .none
                
            default:
                return .none
            }
        }
//        .forEach(\.offCalendars, action: /Action.offCalendars(id:action:)) {
//            OffCalendarStore()
//        }
        .forEach(\.tradeItems, action: /Action.tradeItems(id:action:)) {
            TradeItemCellStore()
        }
        .ifLet(\.$selectTicker, action: /Action.selectTicker) {
            SelectTickerStore()
        }
        .ifLet(\.$editTrade, action: /Action.editTrade) {
            EditTradeStore()
        }
    }
}

public extension ToffCalendarMainStore.State {
//    func makeOffCalendarStoreState(
//        id: UUID = .init(),
//        date: Date,
//        trades: [Trade]
//    ) -> OffCalendarStore<Trade>.State {
//        let makeOffCalendarPreviewCellStoreState: (Trade) -> OffCalendarPreviewCellStore.State = { trade in
//            return .init(
//                title: trade.ticker?.name ?? "",
//                color: trade.side == .buy ? .pink : .mint
//            )
//        }
//        let makeOffCalendarItemCellState: (Date, [Trade]) -> OffCalendarItemCellStore<Trade>.State = { date, trades in
//            return .init(
//                date: date,
//                isSelected: false,
//                data: trades.filter({ $0.date.isEqual(date: date) }),
//                makeOffCalendarPreviewCellStoreState: makeOffCalendarPreviewCellStoreState
//            )
//        }
//        
//        return .init(
//            id: id,
//            initialDate: date,
//            data: trades,
//            makeOffCalendarItemCellState: makeOffCalendarItemCellState
//        )
//    }
    
//    func updateOffCalendars(
//        offCalendars: IdentifiedArrayOf<OffCalendarStore<Trade>.State>,
//        trades: [Trade]
//    ) -> IdentifiedArrayOf<OffCalendarStore<Trade>.State> {
//        var offCalendars = offCalendars
//        for id in offCalendars.ids {
//            offCalendars[id: id]?.data = trades
//        }
//        return offCalendars
//    }
    
    func makeTradeItems(from trades: [Trade]) -> IdentifiedArrayOf<TradeItemCellStore.State> {
        return .init(
            uniqueElements: trades.map { trade in
                return .init(trade: trade, dateStyle: .short, timeStyle: .short)
            }
        )
    }
}
