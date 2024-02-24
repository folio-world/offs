//
//  InvestmentRepository.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Supabase
import Dependencies

import Shared
import AuthenticationServices

public protocol InvestmentRepositoryInterface {
    func fetches() async throws -> [InvestmentDTO]
    func insert(investment: InvestmentDTO) async throws -> Void
}

public class InvestmentRepository: InvestmentRepositoryInterface {
    public let client = SupabaseClientProvider.client
    
    public init() {}
    
    public func fetches() async throws -> [InvestmentDTO] {
        return try await client.database
            .from("investment")
            .select()
            .execute()
            .value
    }
    
    public func insert(investment: InvestmentDTO) async throws -> Void {
        return try await client.database
            .from("investment")
            .insert(investment, returning: .representation)
            .single()
            .execute()
            .value
    }
}

extension InvestmentRepository: TestDependencyKey, DependencyKey {
    public static var testValue: InvestmentRepository = unimplemented()
    public static var liveValue: InvestmentRepository = .init()
}

public extension DependencyValues {
    var supabaseInvestmentDataSource: InvestmentRepository {
        get { self[InvestmentRepository.self] }
        set { self[InvestmentRepository.self] = newValue }
    }
}
