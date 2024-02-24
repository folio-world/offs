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

extension DependencyValues {
    public mutating func prepareLive() {
        let investmentRepository = InvestmentRepository()
        let authRepository = AuthRepository()
        
        self.authClient = .live(authRepository: authRepository)
        self.investmentClient = .live(investmentRepository: investmentRepository)
    }
}
