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

public struct CalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let id: UUID
        public var trades: [Trade]
        
        public var calendarTabItems: [CalendarTabItem] = []
        public var currentTab: UUID
        
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
            self.calendarTabItems = [
                CalendarObjectMapper.calendarTabItem(date: Date().add(byAdding: .month, value: -1), trades: trades),
                CalendarObjectMapper.calendarTabItem(id: currentTab, date: Date(), trades: trades),
                CalendarObjectMapper.calendarTabItem(date: Date().add(byAdding: .month, value: 1), trades: trades)
            ]
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        case refresh
        
        case selectTab(UUID)
        case cellTapped(CalendarCellItem)
        case newButtonTapped
        
        case fetchTradesResponse([Trade])
        
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
                let oldTabId = state.currentTab
                let newTabId = tab
                let calendarTabItems = state.calendarTabItems
                let trades = state.trades
                
                state.currentTab = tab
                
                guard
                    let firstTabId = calendarTabItems.first?.id,
                    let lastTabId = calendarTabItems.last?.id,
                    let oldTabIndex = calendarTabItems.firstIndex(where: { $0.id == oldTabId }),
                    let newTabIndex = calendarTabItems.firstIndex(where: { $0.id == newTabId }),
                    [firstTabId, lastTabId].contains(tab)
                else { return .none }
                
                let newTabDate = calendarTabItems[newTabIndex].date
                let offset = newTabIndex - oldTabIndex
                let newCalendarTabItem = CalendarObjectMapper.calendarTabItem(date: newTabDate.add(byAdding: .month, value: offset), trades: trades)
                
                switch tab {
                case firstTabId:
                    state.calendarTabItems.insert(newCalendarTabItem, at: 0)
                case lastTabId:
                    state.calendarTabItems.append(newCalendarTabItem)
                default:
                    break
                }
                
                return .none
                
            case .newButtonTapped:
                state.selectTicker = .init()
                return .none
                
            case let .fetchTradesResponse(trades):
                state.trades = trades
                state.calendarTabItems = [
                    CalendarObjectMapper.calendarTabItem(date: Date().add(byAdding: .month, value: -1), trades: trades),
                    CalendarObjectMapper.calendarTabItem(id: state.currentTab, date: Date(), trades: trades),
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
