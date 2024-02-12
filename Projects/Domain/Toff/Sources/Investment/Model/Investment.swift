//
//  Investment.swift
//  Domain
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

public struct Investment {
    public let id: Int
    public let type: InvestmentType
    public let currency: CurrencyType
    public let symbol: String
    public let memo: String
    
    public init(
        id: Int,
        type: InvestmentType,
        currency: CurrencyType,
        symbol: String,
        memo: String
    ) {
        self.id = id
        self.type = type
        self.currency = currency
        self.symbol = symbol
        self.memo = memo
    }
}
