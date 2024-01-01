//
//  TradeClient.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/11.
//

import Foundation
import SwiftData

import ComposableArchitecture

import SharedDesignSystem

public enum TradeError: Error {
    case unknown
}

public struct TradeClient {
    public static let tradeRepository: TradeRepositoryInterface = TradeRepository()
    
    public var fetchTrades: () -> Result<[Trade], TradeError>
    public var saveTrade: (TradeDTO) -> Result<Trade, TradeError>
    public var updateTrade: (Trade, TradeDTO) -> Result<Trade, TradeError>
    public var deleteTrade: (Trade) -> Result<Trade, TradeError>
    
    public var fetchOffCalendarItems: (Date, [Trade]) -> [OffCalendarItem]
    
    public init(
        fetchTrades: @escaping () -> Result<[Trade], TradeError>,
        saveTrade: @escaping (TradeDTO) -> Result<Trade, TradeError>,
        updateTrade: @escaping (Trade, TradeDTO) -> Result<Trade, TradeError>,
        deleteTrade: @escaping (Trade) -> Result<Trade, TradeError>,
        
        fetchOffCalendarItems: @escaping (Date, [Trade]) -> [OffCalendarItem]
    ) {
        self.fetchTrades = fetchTrades
        self.saveTrade = saveTrade
        self.updateTrade = updateTrade
        self.deleteTrade = deleteTrade
        
        self.fetchOffCalendarItems = fetchOffCalendarItems
    }
}

extension TradeClient: TestDependencyKey {
    public static var previewValue: TradeClient = Self(
        fetchTrades: { return .failure(.unknown) },
        saveTrade: { _ in return .failure(.unknown) },
        updateTrade: { _, _ in return .failure(.unknown) },
        deleteTrade: { _ in return .failure(.unknown) },
        
        fetchOffCalendarItems: { _, _ in return [] }
    )
    
    public static var testValue = Self(
        fetchTrades: unimplemented("\(Self.self).fetchTrades"),
        saveTrade: unimplemented("\(Self.self).saveTrade"),
        updateTrade: unimplemented("\(Self.self).updateTrade"),
        deleteTrade: unimplemented("\(Self.self).deleteTrade"),
        
        fetchOffCalendarItems: unimplemented("\(Self.self).fetchOffCalendarItems")
    )
}

public extension DependencyValues {
    var tradeClient: TradeClient {
        get { self[TradeClient.self] }
        set { self[TradeClient.self] = newValue }
    }
}

extension TradeClient: DependencyKey {
    public static var liveValue = TradeClient(
        fetchTrades: { tradeRepository.fetchTrades(descriptor: .init()) },
        saveTrade: { tradeRepository.saveTrade($0) },
        updateTrade: { tradeRepository.updateTrade($0, new: $1) },
        deleteTrade: { tradeRepository.deleteTrade($0) },
        
        fetchOffCalendarItems: { TradeObjectMapper.OffCalendarItemsOfMonth(date: $0, trades: $1) }
    )
}