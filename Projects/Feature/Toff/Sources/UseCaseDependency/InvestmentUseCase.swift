//
//  InvestmentUseCase.swift
//  ToffFeature
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

import Dependencies

import ToffData
import ToffDomain

extension InvestmentUseCase: TestDependencyKey, DependencyKey {
    public static var testValue: InvestmentUseCase = unimplemented()
    public static var liveValue: InvestmentUseCase = .init(
        investmentRepository: DependencyValues.live.investmentRepository
    )
}

public extension DependencyValues {
    var investmentUseCase: InvestmentUseCase {
        get { self[InvestmentUseCase.self] }
        set { self[InvestmentUseCase.self] = newValue }
    }
}
