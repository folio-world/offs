//
//  InvestmentDTO.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Foundation
import ToffDomain

import Supabase

public struct InvestmentDTO: Codable {
    let id: Int
    let currency: CurrencyTypeDTO
    let symbol: String
    let memo: String
    let type: InvestmentTypeDTO
    let created_at: Date
    
}

public extension InvestmentDTO {
    func toDomain() -> Investment {
        return .init(
            id: self.id,
            type: self.type.toDomain(),
            currency: self.currency.toDomain(),
            symbol: self.symbol,
            memo: self.memo
        )
    }
}

public extension Investment {
    func toDTO() -> InvestmentDTO {
        return .init(
            id: self.id,
            currency: self.currency.toDTO(),
            symbol: self.symbol,
            memo: self.memo,
            type: self.type.toDTO(),
            created_at: Date()
        )
    }
}
