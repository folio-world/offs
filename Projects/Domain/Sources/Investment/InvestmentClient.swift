//
//  InvestmentClient.swift
//  Domain
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import ComposableArchitecture

public struct InvestmentClient {
    public var fetch: () -> [Investment]
    public var create: () -> Bool
    public var update: () -> Bool
    public var delete: () -> Bool
        
    public init(
        fetch: @escaping () -> [Investment],
        create: @escaping () -> Bool,
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
        create: { return false },
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

extension InvestmentClient: DependencyKey {
    public static var liveValue = InvestmentClient(
        fetch: { [] },
        create: { true },
        update: { true },
        delete: { true }
    )
}
