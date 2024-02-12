//
//  InvestmentRepository.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

import Auth
import Dependencies

import ToffDomain

public class InvestmentRepository: InvestmentRepositoryInterface {
    let supabaseInvestmentDataSource: SupabaseInvestmentDataSourceInterface
    
    public init(supabaseInvestmentDataSource: SupabaseInvestmentDataSourceInterface) {
        self.supabaseInvestmentDataSource = supabaseInvestmentDataSource
    }
    
    public func fetches() async throws -> [Investment] {
        return try await supabaseInvestmentDataSource.fetches().map { $0.toDomain() }
    }
    
    public func insert(investment: Investment) async throws {
        return try await supabaseInvestmentDataSource.insert(investment: investment.toDTO())
    }
}

extension InvestmentRepository: TestDependencyKey, DependencyKey {
    public static var testValue: InvestmentRepository = unimplemented()
    public static var liveValue: InvestmentRepository = .init(
        supabaseInvestmentDataSource: DependencyValues.live.supabaseInvestmentDataSource
    )
}

public extension DependencyValues {
    var investmentRepository: InvestmentRepository {
        get { self[InvestmentRepository.self] }
        set { self[InvestmentRepository.self] = newValue }
    }
}
