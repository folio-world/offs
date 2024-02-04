//
//  AuthUseCase.swift
//  Domain
//
//  Created by 송영모 on 2/4/24.
//

import Foundation
import Auth

public protocol AuthUseCaseInterface {
    func signIn(idToken: String) async throws -> Session
}

public class AuthUseCase: AuthUseCaseInterface {
    private let authRepository: AuthRepositoryInterface
    
    public init(authRepository: AuthRepositoryInterface) {
        self.authRepository = authRepository
    }
    
    public func signIn(idToken: String) async throws -> Session {
        return try await authRepository.signIn(idToken: idToken)
    }
}
