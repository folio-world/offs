//
//  AuthRepository.swift
//  ToffData
//
//  Created by 송영모 on 2/4/24.
//

import Foundation

import Auth
import Dependencies

import ToffDomain

public class AuthRepository: AuthRepositoryInterface {
    let supabaseAuthDataSource: SupabaseAuthDataSourceInterface
    
    public init(supabaseAuthDataSource: SupabaseAuthDataSourceInterface) {
        self.supabaseAuthDataSource = supabaseAuthDataSource
    }
    
    public func signIn(idToken: String) async throws -> Session {
        return try await supabaseAuthDataSource.signInWithAppleIdToken(idToken: idToken)
    }
}

extension AuthRepository: TestDependencyKey, DependencyKey {
    public static var testValue: AuthRepository = unimplemented()
    public static var liveValue: AuthRepository = .init(
        supabaseAuthDataSource: DependencyValues.live.supabaseAuthDataSource
    )
}

public extension DependencyValues {
    var authRepository: AuthRepository {
        get { self[AuthRepository.self] }
        set { self[AuthRepository.self] = newValue }
    }
}
