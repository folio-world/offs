//
//  Investment.swift
//  Domain
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

public struct Investment {
    let id: UUID
    let type: InvestmentType
    let currency: CurrencyType
    let name: String
    
    public init(
        id: UUID = .init(),
        type: InvestmentType,
        currency: CurrencyType,
        name: String
    ) {
        self.id = id
        self.type = type
        self.currency = currency
        self.name = name
    }
}
