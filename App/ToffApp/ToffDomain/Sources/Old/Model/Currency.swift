//
//  Tradecurrency.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/09/04.
//

import Foundation

public enum Currency: String, Codable, CaseIterable, Equatable {
    case dollar = "USD"             // 미국: 달러
    case euro = "EUR"               // 유럽: 유로
    case yen = "JPY"                // 일본: 옌
    case sterling = "GBP"           // 영국: 스털링
    case australianDollar = "AUD"   // 오스트레일리아: 오스트레일리아 달러
    case canadianDollar = "CAD"     // 캐나다: 캐나다 달러
    case franc = "CHF"              // 스위스: 프랑
    case krona = "SEK"              // 스웨덴: 크로나
    case peso = "MXN"               // 멕시코: 페소
    case newZealandDollar = "NZD"   // 뉴질랜드: 뉴질랜드 달러
    case singaporeDollar = "SGD"    // 싱가포르: 싱가포르 달러
    case hongKongDollar = "HKD"     // 홍콩: 홍콩 달러
    case krone = "NOK"              // 노르웨이: 크로네
    case won = "KRW"                // 대한민국: 원
    
    case bitcoin = "BTC"            // 비트코인
    
//    {"base":"EUR","date":"2024-01-25","rates":{"USD":1.090000000,"JPY":160.810000000,"BGN":1.960000000,"CZK":24.760000000,"DKK":7.460000000,"GBP":0.860000000,"HUF":385.180000000,"PLN":4.380000000,"RON":4.980000000,"SEK":11.350000000,"CHF":0.940000000,"ISK":148.100000000,"NOK":11.390000000,"TRY":32.990000000,"AUD":1.650000000,"BRL":5.370000000,"CAD":1.470000000,"CNY":7.810000000,"HKD":8.510000000,"IDR":17266.550000000,"ILS":4.030000000,"INR":90.550000000,"KRW":1456.250000000,"MXN":18.760000000,"MYR":5.150000000,"NZD":1.780000000,"PHP":61.560000000,"SGD":1.460000000,"THB":38.930000000,"ZAR":20.580000000,"EUR":1.000000000,"BTC":0.000000000}}
    /*
    case florin = "AWG"
    case turkishlira = "TRY"
    case ruble = "RUB"
    case dong = "VND"
    case indianrupee = "INR"
    case tenge = "KZT"
    case peseta = "ESP"
    case kip = "LAK"
    case hryvnia = "UAH"
    case naira = "NGN"
    case guarani = "PYG"
    case coloncurrency = "CRC"
    case cedi = "GHS"
    case tugrik = "MNT"
    case shekel = "ILS"
    case manat = "AZN"
    case baht = "THB"
    case lari = "GEL"
    case brazilianreal = "BRL"
     */
}
