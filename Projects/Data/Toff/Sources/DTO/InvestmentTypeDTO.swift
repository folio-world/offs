//
//  InvestmentTypeDTO.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

import ToffDomain

public enum InvestmentTypeDTO: String, Codable {
    case stock = "Stock" // 주식: 회사의 소유권을 나타내며, 주식시장에서 거래됩니다.
    case crypto = "Crypto" // 암호화폐: 디지털 또는 가상 통화로, 보안을 위해 암호화가 사용됩니다.
    case gold = "Gold" // 금: 귀중한 금속으로, 전통적인 가치 저장 수단 및 투자 자산입니다.
    case realEstate = "RealEstate" // 부동산: 토지 및 그 위에 있는 모든 자원을 포함한 물리적 재산입니다.
    case bond = "Bond" // 채권: 정부 또는 기업이 자금을 빌리기 위해 발행하는 빚증서입니다.
    case commodity = "Commodity" // 상품: 원자재 또는 기본 상품으로, 시장에서 거래됩니다.
    case etf = "ETF" // ETF(상장지수펀드): 주식시장에서 거래되는 투자 기금으로, 다양한 자산을 추적합니다.
    case peerToPeerLending = "PeerToPeerLending" // P2P대출: 개인 간 대출을 위한 플랫폼을 통해 이루어지는 대출입니다.
    case savings = "Savings" // 예금/적금: 은행 또는 금융기관에 돈을 예치하고 일정 기간 후 이자를 받는 방식입니다.
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

