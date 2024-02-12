//
//  SupabaseInvestmentDataSource.swift
//  ToffData
//
//  Created by 송영모 on 2/12/24.
//

import Foundation

import Supabase
import Dependencies

import Shared
import AuthenticationServices
import ToffDomain

public protocol SupabaseInvestmentDataSourceInterface {
    func fetches() async throws -> [InvestmentDTO]
    func insert(investment: InvestmentDTO) async throws -> Void
}

public class SupabaseInvestmentDataSource: SupabaseInvestmentDataSourceInterface {
    public let client = SupabaseClientProvider.client
    
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

extension SupabaseInvestmentDataSource: TestDependencyKey, DependencyKey {
    public static var testValue: SupabaseInvestmentDataSource = unimplemented()
    public static var liveValue: SupabaseInvestmentDataSource = .init()
}

public extension DependencyValues {
    var supabaseInvestmentDataSource: SupabaseInvestmentDataSource {
        get { self[SupabaseInvestmentDataSource.self] }
        set { self[SupabaseInvestmentDataSource.self] = newValue }
    }
}
