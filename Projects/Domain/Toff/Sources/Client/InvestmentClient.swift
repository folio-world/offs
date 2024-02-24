//
//  InvestmentClient.swift
//  Domain
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import Dependencies

public struct InvestmentClient {
    public var fetch: () async throws -> [Investment]
    public var create: (Investment) async throws -> Void
    public var update: () -> Bool
    public var delete: () -> Bool
        
    public init(
        fetch: @escaping () async throws -> [Investment],
        create: @Sendable @escaping (Investment) async throws -> Void,
        update: @escaping () -> Bool,
        delete: @escaping () -> Bool
    ) {
        self.fetch = fetch
        self.create = create
        self.update = update
        self.delete = delete
    }
}

extension InvestmentClient: TestDependencyKey {
    public static var previewValue: InvestmentClient = Self(
        fetch: { return [] },
        create: { _ in },
        update: { return false },
        delete: { return false }
    )
    
    public static var testValue = Self(
        fetch: unimplemented("\(Self.self).fetch"),
        create: unimplemented("\(Self.self).create"),
        update: unimplemented("\(Self.self).update"),
        delete: unimplemented("\(Self.self).delete")
    )
}

public extension DependencyValues {
    var investmentClient: InvestmentClient {
        get { self[InvestmentClient.self] }
        set { self[InvestmentClient.self] = newValue }
    }
}

extension InvestmentClient {
    public static func live(investmentRepository: InvestmentRepositoryInterface) -> Self {
        return .init(
            fetch: {
                try await investmentRepository.fetches().map { $0.toDomain() }
            },
            create: { investment in
                return try await investmentRepository.insert(investment: investment.toDTO())
            },
            update: { true },
            delete: { true }
        )
    }
}
