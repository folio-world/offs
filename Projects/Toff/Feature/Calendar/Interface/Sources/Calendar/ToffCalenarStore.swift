////
////  ToffCalenarStore.swift
////  ToffFeatureCalendarInterface
////
////  Created by 송영모 on 10/11/23.
////
//
//import Foundation
//
//import ComposableArchitecture
//
//import OffFeatureCalendarInterface
//import ToffFeatureTradeInterface
//import ToffDomain
//
//public struct ToffCalendarStore: Reducer {
//    public init() {}
//    
//    public struct State: Equatable, Identifiable {
//        public let id: UUID
//        public var trades: [Trade]
//        public var selectedDate: Date
//        
//        public var offCalendars: IdentifiedArrayOf<OffCalendarStore<Trade>.State> = []
//        public var tradeItems: IdentifiedArrayOf<TradeItemCellStore.State> = []
//        
//        public init(
//            id: UUID = .init(),
//            trades: [Trade],
//            selectedDate: Date
//        ) {
//            self.id = id
//            self.trades = trades
//            self.selectedDate = selectedDate
//            self.offCalendars = .init(
//                uniqueElements: [
//                    makeOffCalendarStoreState(date: .now.add(byAdding: .month, value: -1), trades: trades),
//                    makeOffCalendarStoreState(id: id, date: .now, trades: trades),
//                    makeOffCalendarStoreState(date: .now.add(byAdding: .month, value: 1), trades: trades)
//                ]
//            )
//        }
//    }
//    
//    public enum Action: Equatable {
//        case onAppear
//        
//        case offCalendars(id: OffCalendarStore<Trade>.State.ID, action: OffCalendarStore<Trade>.Action)
//        case tradeItems(id: TradeItemCellStore.State.ID, action: TradeItemCellStore.Action)
//        
//        case delegate(Delegate)
//        
//        public enum Delegate: Equatable {
//            case tapped
//        }
//    }
//    
//    public var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .onAppear:
//                state.tradeItems = state.makeTradeItems(from: state.trades.filter({ $0.date.isEqual(date: state.selectedDate) }))
//                return .none
//                
//            case let .offCalendars(id: id, action: .delegate(.tapped)):
//                state.offCalendars[id: id]?.selectedDate
//                return .none
//
//            default:
//                return .none
//            }
//        }
//    }
//}
//
//public extension ToffCalendarStore.State {
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
//                makeOffCalendarPreviewCellStoreState: makeOffCalendarPreviewCellStoreState)
//        }
//        
//        return .init(
//            id: id,
//            dates: date.allDatesInMonth(),
//            selectedDate: date,
//            data: trades,
//            makeOffCalendarItemCellState: makeOffCalendarItemCellState
//        )
//    }
//    
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
//    
//    func makeTradeItems(from trades: [Trade]) -> IdentifiedArrayOf<TradeItemCellStore.State> {
//        return .init(
//            uniqueElements: trades.map { trade in
//                return .init(trade: trade, dateStyle: .short, timeStyle: .short)
//            }
//        )
//    }
//}
