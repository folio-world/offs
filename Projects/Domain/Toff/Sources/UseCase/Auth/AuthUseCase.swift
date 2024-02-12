//
//  AuthUseCase.swift
//  Domain
//
//  Created by 송영모 on 2/4/24.
//

import Foundation
import Auth

public protocol AuthUseCaseInterface {
    func signIn(from idToken: String) async throws -> Session
    func refresh() async throws -> Void
    func user() async throws -> UserEntity
}

public class AuthUseCase: AuthUseCaseInterface {
    private let authRepository: AuthRepositoryInterface
    
    public init(authRepository: AuthRepositoryInterface) {
        self.authRepository = authRepository
    }
    
    public func signIn(from idToken: String) async throws -> Session {
        return try await authRepository.signIn(from: idToken)
    }
    
    public func refresh() async throws {
        return try await authRepository.refresh()
    }
    
    public func user() async throws -> UserEntity {
        return try await authRepository.user()
    }
}
