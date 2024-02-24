//
//  InvestmentTypeDTO.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

import ToffDomain

public enum InvestmentTypeDTO: String, Codable {
    case stock
    case crypto
    case gold
    case realEstate
    case bond
    case commodity
    case etf
    case peerToPeerLending
    case savings
}

public extension InvestmentTypeDTO {
    func toDomain() -> InvestmentType {
        switch self {
        case .stock: .stock
        case .crypto: .crypto
        case .gold: .gold
        case .realEstate: .realEstate
        case .bond: .bond
        case .commodity: .commodity
        case .etf: .etf
        case .peerToPeerLending: .peerToPeerLending
        case .savings: .savings
        }
    }
}

public extension InvestmentType {
    func toDTO() -> InvestmentTypeDTO {
        switch self {
        case .stock: .stock
        case .crypto: .crypto
        case .gold: .gold
        case .realEstate: .realEstate
        case .bond: .bond
        case .commodity: .commodity
        case .etf: .etf
        case .peerToPeerLending: .peerToPeerLending
        case .savings: .savings
        }
    }
}

