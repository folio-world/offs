//
//  HomeMainStore.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2024/01/20.
//

import Foundation

import ComposableArchitecture

import ToffDomain
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
    
    public enum Action {
        case onAppear
        
        case fetchTickerResponse([Ticker])
        case insertInvestmentResponse(Result<Void, any Error>)
        
        public enum Delegate: Equatable {
            
        }
    }
    
    @Dependency(\.tickerClient) var tickerClient
    @Dependency(\.investmentClient) private var investmentClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .merge([
                    .send(.fetchTickerResponse(tickerClient.fetchTickers())),
                    .run { send in
                        await send(.insertInvestmentResponse(Result { try await investmentClient.create(.init(id: 0, type: .crypto, currency: .aud, symbol: "test", memo: "test memo")) }))
                    }
                ])
                
            case let .fetchTickerResponse(tickers):
                state.tickers = tickers
                return .none
                
            case let .insertInvestmentResponse(result):
                switch result {
                case .success:
                    return .none
                case let .failure(error):
                    print("#@# \(error)")
                    return .none
                }
            }
        }
    }
}
