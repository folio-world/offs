//
//  CurrencyDTO.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

import ToffDomain

public enum CurrencyTypeDTO: String, Codable {
    case usd = "USD"        // 달러
    case jpy = "JPY"        // 엔
    case bgn = "BGN"        // 레프
    case czk = "CZK"        // 코루나
    case dkk = "DKK"        // 크로네
    case gbp = "GBP"        // 파운드
    case huf = "HUF"        // 포린트
    case pln = "PLN"        // 즈워티
    case ron = "RON"        // 레우
    case sek = "SEK"        // 크로나
    case chf = "CHF"        // 프랑
    case isk = "ISK"        // 크로나
    case nok = "NOK"        // 크로네
    case `try` = "TRY"      // 리라
    case aud = "AUD"        // 오스트레일리아 달러
    case brl = "BRL"        // 레알
    case cad = "CAD"        // 캐나다 달러
    case cny = "CNY"        // 위안
    case hkd = "HKD"        // 홍콩 달러
    case idr = "IDR"        // 루피아
    case ils = "ILS"        // 셰켈
    case inr = "INR"        // 루피
    case krw = "KRW"        // 원
    case mxn = "MXN"        // 페소
    case myr = "MYR"        // 링깃
    case nzd = "NZD"        // 뉴질랜드 달러
    case php = "PHP"        // 페소
    case sgd = "SGD"        // 싱가포르 달러
    case thb = "THB"        // 바트
    case zar = "ZAR"        // 랜드
    case eur = "EUR"        // 유로
    case btc = "BTC"        // 비트코인
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

