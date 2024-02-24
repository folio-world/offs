//
//  TransactionRecord.swift
//  Domain
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

public struct TransactionRecord {
    public let id: UUID
    public var type: TransactionType
    public var date: Date
    public var price: Double
    public var quantity: Double
    public var fee: Double
    public var memo: String
    
    public init(
        id: UUID,
        type: TransactionType,
        price: Double,
        quantity: Double,
        fee: Double,
        memo: String,
        date: Date
    ) {
        self.id = id
        self.type = type
        self.price = price
        self.quantity = quantity
        self.fee = fee
        self.memo = memo
        self.date = date
    }
}
