//
//  AuthClient.swift
//  ToffDomain
//
//  Created by 송영모 on 2/24/24.
//

import Foundation

import Dependencies

public struct AuthClient {
    public var refresh: () async throws -> Void
    public var signIn: (String) async throws -> Void
    public var user: () async throws -> UserEntity
        
    public init(
        refresh: @escaping () async throws -> Void,
        signIn: @escaping (String) async throws -> Void,
        user: @escaping () async throws -> UserEntity
    ) {
        self.refresh = refresh
        self.signIn = signIn
        self.user = user
    }
}

extension AuthClient: TestDependencyKey {
    public static var previewValue: AuthClient = Self(
        refresh: { },
        signIn: { _ in },
        user: { .init(id: .init(), provider: .apple) }
    )
    
    public static var testValue = Self(
        refresh: { },
        signIn: { _ in },
        user: { .init(id: .init(), provider: .apple) }
    )
}

public extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

extension AuthClient {
    public static func live(authRepository: AuthRepositoryInterface) -> Self {
        return Self(
            refresh: {
                try await authRepository.refreshSession()
            },
            signIn: { appleToken in
                try await authRepository.signIn(from: appleToken)
            },
            user: {
                return try await authRepository.user().toDomain()
            }
        )
    }
}
