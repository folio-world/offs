//
//  CalendarMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import Foundation

import ComposableArchitecture

import SharedDesignSystem
import ToffDomain

public struct CalendarMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let id: UUID
        public var trades: [Trade]

        public var calendarTabItems: IdentifiedArrayOf<CalendarTabItem> = []

        public var currentTab: UUID
        
        public var headerDate: Date
        public var selectedDate: Date

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
            let prevMonthDate = Date().add(byAdding: .month, value: -1)
            let currentMonthDate = Date()
            let nextMonthDate = Date().add(byAdding: .month, value: 1)

            self.calendarTabItems = [
                CalendarObjectMapper.calendarTabItem(date: prevMonthDate, selectedDate: prevMonthDate, trades: trades),
                CalendarObjectMapper.calendarTabItem(id: currentTab, date: currentMonthDate, selectedDate: currentMonthDate, trades: trades),
                CalendarObjectMapper.calendarTabItem(date: nextMonthDate, selectedDate: nextMonthDate, trades: trades)
            ]
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        case refresh
        
        case selectTab(UUID)
        case calendarCellItemTapped(CalendarCellItem)
        case tradeItemTapped(Trade)
        case newTradeItemTapped
        
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
                    let newTabIndex = calendarTabItems.firstIndex(where: { $0.id == newTabId })
                else { return .none }
                
                let newTabDate = calendarTabItems[newTabIndex].date
                let offset = newTabIndex - oldTabIndex
                let offsetTabDate = newTabDate.add(byAdding: .month, value: offset)
                
                state.headerDate = offsetTabDate
                
                guard [firstTabId, lastTabId].contains(tab) else { return .none }
                
                let newCalendarTabItem = CalendarObjectMapper.calendarTabItem(date: offsetTabDate, selectedDate: offsetTabDate, trades: trades)
                switch tab {
                case firstTabId:
                    state.calendarTabItems.insert(newCalendarTabItem, at: 0)
                case lastTabId:
                    state.calendarTabItems.append(newCalendarTabItem)
                default:
                    break
                }
                
                return .none
                
            case let .calendarCellItemTapped(item):
                state.selectedDate = item.date
                state.calendarTabItems[id: state.currentTab]?.selectedDate = item.date
                if let ids = state.calendarTabItems[id: state.currentTab]?.cells.ids {
                    for id in ids {
                        state.calendarTabItems[id: state.currentTab]?.cells[id: id]?.isSelected = false
                    }
                }
                state.calendarTabItems[id: state.currentTab]?.cells[id: item.id]?.isSelected = true
                return .none
                
            case let .tradeItemTapped(trade):
                return .send(.delegate(.detail(trade)))
                
            case .newTradeItemTapped:
                state.selectTicker = .init()
                return .none
                
            case let .fetchTradesResponse(trades):
                state.trades = trades
                state.calendarTabItems = makeCalendarTabItems(trades: trades, currentTab: state.currentTab)
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
                return .send(.refresh)
                
            case .editTrade(.dismiss):
                state.editTrade = nil
                return .none
                
            case .editTrade, .selectTicker, .delegate, .refresh:
                return .none
            }
        }
        .ifLet(\.$selectTicker, action: /Action.selectTicker) {
            SelectTickerStore()
        }
        .ifLet(\.$editTrade, action: /Action.editTrade) {
            EditTradeStore()
        }
    }
    
    private func makeCalendarTabItems(
        trades: [Trade],
        currentTab: UUID
    ) -> IdentifiedArrayOf<CalendarTabItem> {
        let prevMonthDate = Date().add(byAdding: .month, value: -1)
        let currentMonthDate = Date()
        let nextMonthDate = Date().add(byAdding: .month, value: 1)
        
        return [
            CalendarObjectMapper.calendarTabItem(date: prevMonthDate, selectedDate: prevMonthDate, trades: trades),
            CalendarObjectMapper.calendarTabItem(id: currentTab, date: currentMonthDate, selectedDate: currentMonthDate, trades: trades),
            CalendarObjectMapper.calendarTabItem(date: nextMonthDate, selectedDate: nextMonthDate, trades: trades)
        ]
    }
}
