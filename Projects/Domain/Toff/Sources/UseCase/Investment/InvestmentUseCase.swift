//
//  InvestmentUseCase.swift
//  ToffDomain
//
//  Created by 송영모 on 2/12/24.
//

import Foundation
import Auth

public protocol InvestmentUseCaseInterface {
    func fetches() async throws -> [Investment]
    func insert(invesetment: Investment) async throws -> Void
}

public class InvestmentUseCase: InvestmentUseCaseInterface {
    private let investmentRepository: InvestmentRepositoryInterface
    
    public init(investmentRepository: InvestmentRepositoryInterface) {
        self.investmentRepository = investmentRepository
    }
    
    public func fetches() async throws -> [Investment] {
        return try await investmentRepository.fetches()
    }
    
    public func insert(invesetment: Investment) async throws {
        return try await investmentRepository.insert(investment: invesetment)
    }
}
