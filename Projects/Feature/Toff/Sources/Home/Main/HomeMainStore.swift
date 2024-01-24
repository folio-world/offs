//
//  HomeMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2024/01/20.
//

import Foundation

import ComposableArchitecture

import Domain
import SharedDesignSystem

public struct HomeMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let id: UUID
        
        public var tickers: [Ticker]
        
        public init(
            id: UUID = .init(),
            tickers: [Ticker] = []
        ) {
            self.id = id
            self.tickers = tickers
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        case fetchTickerResponse([Ticker])
        
        public enum Delegate: Equatable {
            
        }
    }
    
    @Dependency(\.tickerClient) var tickerClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.fetchTickerResponse(tickerClient.fetchTickers()))
                
            case let .fetchTickerResponse(tickers):
                state.tickers = tickers
                return .none
            }
        }
    }
}
