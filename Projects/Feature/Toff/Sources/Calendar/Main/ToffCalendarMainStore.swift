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
        
        public var calendarTabItems: [CalendarTabItem] = []
        @BindingState public var currentTab: UUID
        
        public var headerDate: Date
        public var selectedDate: Date

//        public var tradeItems: IdentifiedArrayOf<TradeItemCellStore.State> = []
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
            
            self.currentTab = .init()
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        case refresh
        
        case selectTab(UUID)
        case cellTapped(CalendarCellItem)
        case newButtonTapped
        
        case fetchTradesResponse([Trade])
        
//        case tradeItems(id: TradeItemCellStore.State.ID, action: TradeItemCellStore.Action)
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
                let trades = tradeClient.fetchTrades()
                
                return .concatenate([
                    .send(.fetchTradesResponse(trades))
                ])
                
            case let .selectTab(tab):
                state.currentTab = tab
//                let currentTabIndex =
//                let initialTabIndex = 0
//                let currentTabIndex = 0
//                let offset = currentTabIndex - initialTabIndex
//                let addMonthValue = currentTabIndex > initialTabIndex ? offset + 1 : offset - 1
                
//                let date = Date.now.add(
//                    byAdding: .month,
//                    value: addMonthValue
//                )
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
                
//                state.currentTabIndex = tabIndex
//                state.selectedDate = state.offCalendars[id: tab]?.selectedDate ?? .now
//                state.headerDate = state.offCalendars[id: tab]?.initialDate ?? .now
                return .none
                
            case .newButtonTapped:
                state.selectTicker = .init()
                return .none
                
            case let .fetchTradesResponse(trades):
                state.trades = trades
                state.calendarTabItems = [
                    CalendarObjectMapper.calendarTabItem(date: Date().add(byAdding: .month, value: -1), trades: trades),
                    CalendarObjectMapper.calendarTabItem(date: Date(), trades: trades),
                    CalendarObjectMapper.calendarTabItem(date: Date().add(byAdding: .month, value: 1), trades: trades)
                ]
                return .none
                
//            case let .tradeItems(id: id, action: .delegate(.tapped)):
//                if let trade = state.tradeItems[id: id]?.trade {
//                    return .send(.delegate(.detail(trade)))
//                }
//                return .none
                
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
                return .send(.refresh)
                
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
//        .forEach(\.tradeItems, action: /Action.tradeItems(id:action:)) {
//            TradeItemCellStore()
//        }
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
    
//    func makeTradeItems(from trades: [Trade]) -> IdentifiedArrayOf<TradeItemCellStore.State> {
//        return .init(
//            uniqueElements: trades.map { trade in
//                return .init(trade: trade, dateStyle: .short, timeStyle: .short)
//            }
//        )
//    }
}
