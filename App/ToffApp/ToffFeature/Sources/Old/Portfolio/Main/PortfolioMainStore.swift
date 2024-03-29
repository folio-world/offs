//
//  PortfolioMainStore.swift
//  ToolinderFeaturePortfolioInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation

import ComposableArchitecture

import ToffDomain

public struct PortfolioMainStore: Reducer {
    public init() {}
    
    public enum Period: String, CaseIterable {
        case month = "Month"
    }
    
    public struct State: Equatable {
        public var trades: [Trade] = []
        public var selectedPeriod: Period = .month
        
        public var tickerTypeChartDataEntity: TickerTypeChartDataEntity = .init()
        public var tradeDateChartDataEntity: TradeDateChartDataEntity = .init()
        
        public var tickerItem: IdentifiedArrayOf<TickerItemCellStore.State> = []
        
        public init() { }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case selectPeriod(Period)
        
        case tickerItemRequest
        case tradeRequest
        case tickerTypeChartDataEntityRequest
        case tradeDateChartDataEntityRequest(from: Date, to: Date)
        case tickerItemResponse(IdentifiedArrayOf<TickerItemCellStore.State>)
        case tradesResponse([Trade])
        case tickerTypeChartDataEntityResponse(TickerTypeChartDataEntity)
        case tradeDateChartDataEntityResponse(TradeDateChartDataEntity)
        
        case tickerItem(id: TickerItemCellStore.State.ID, action: TickerItemCellStore.Action)
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case tickerDetail(Ticker)
        }
    }
    
    @Dependency(\.tickerClient) var tickerClient
    @Dependency(\.tradeClient) var tradeClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .concatenate([
                    .send(.tradeRequest),
                    .send(.tickerItemRequest)
                ])
                
            case let .selectPeriod(period):
                state.selectedPeriod = period
                return .none
                
            case .tickerItemRequest:
                let tickers = tickerClient.fetchTickers()
                return .send(.tickerItemResponse(.init(uniqueElements: tickers.map { .init(ticker: $0) })))
                
                
            case .tradeRequest:
                let trades = tradeClient.fetchTrades()
                return .send(.tradesResponse(trades))
                
            case .tickerTypeChartDataEntityRequest:
                return .send(.tickerTypeChartDataEntityResponse(state.trades.toTickerTypeChartDataEntity()))
                
            case let .tradeDateChartDataEntityRequest(from, to):
                return .send(.tradeDateChartDataEntityResponse(state.trades.toTradeDateChartDataEntity(from: from, to: to)))
                
            case let .tickerItemResponse(items):
                state.tickerItem = items
                return .none
                
            case let .tradesResponse(respnse):
                state.trades = respnse
                return .concatenate([
                    .send(.tickerTypeChartDataEntityRequest),
                    .send(
                        .tradeDateChartDataEntityRequest(
                            from: .now.add(byAdding: .month, value: -1),
                            to: .now)
                    )
                ])
                
            case let .tickerTypeChartDataEntityResponse(response):
                state.tickerTypeChartDataEntity = response
                return .none
                
            case let .tradeDateChartDataEntityResponse(response):
                state.tradeDateChartDataEntity = response
                return .none
                
            case let .tickerItem(id, action: .tapped):
                if let ticker = state.tickerItem[id: id]?.ticker {
                    return .send(.delegate(.tickerDetail(ticker)))
                }
                
                return .none
                
            default:
                return .none
            }
        }
        
        .forEach(\.tickerItem, action: /Action.tickerItem(id:action:)) {
            TickerItemCellStore()
        }
    }
}
