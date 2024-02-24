//
//  CurrencyDTO.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

import ToffDomain

public enum CurrencyTypeDTO: String, Codable {
    case usd
    case jpy
    case bgn
    case czk
    case dkk
    case gbp
    case huf
    case pln
    case ron
    case sek
    case chf
    case isk
    case nok
    case `try`
    case aud
    case brl
    case cad
    case cny
    case hkd
    case idr
    case ils
    case inr
    case krw
    case mxn
    case myr
    case nzd
    case php
    case sgd
    case thb
    case zar
    case eur
    case btc
}

public extension CurrencyTypeDTO {
    func toDomain() -> CurrencyType {
        switch self {
        case .usd: .usd
        case .jpy: .jpy
        case .bgn: .bgn
        case .czk: .czk
        case .dkk: .dkk
        case .gbp: .gbp
        case .huf: .huf
        case .pln: .pln
        case .ron: .ron
        case .sek: .sek
        case .chf: .chf
        case .isk: .isk
        case .nok: .nok
        case .`try`: .`try`
        case .aud: .aud
        case .brl: .brl
        case .cad: .cad
        case .cny: .cny
        case .hkd: .hkd
        case .idr: .idr
        case .ils: .ils
        case .inr: .inr
        case .krw: .krw
        case .mxn: .mxn
        case .myr: .myr
        case .nzd: .nzd
        case .php: .php
        case .sgd: .sgd
        case .thb: .thb
        case .zar: .zar
        case .eur: .eur
        case .btc: .btc
        }
    }
}

public extension CurrencyType {
    func toDTO() -> CurrencyTypeDTO {
        switch self {
        case .usd: .usd
        case .jpy: .jpy
        case .bgn: .bgn
        case .czk: .czk
        case .dkk: .dkk
        case .gbp: .gbp
        case .huf: .huf
        case .pln: .pln
        case .ron: .ron
        case .sek: .sek
        case .chf: .chf
        case .isk: .isk
        case .nok: .nok
        case .`try`: .`try`
        case .aud: .aud
        case .brl: .brl
        case .cad: .cad
        case .cny: .cny
        case .hkd: .hkd
        case .idr: .idr
        case .ils: .ils
        case .inr: .inr
        case .krw: .krw
        case .mxn: .mxn
        case .myr: .myr
        case .nzd: .nzd
        case .php: .php
        case .sgd: .sgd
        case .thb: .thb
        case .zar: .zar
        case .eur: .eur
        case .btc: .btc
        }
    }
}

