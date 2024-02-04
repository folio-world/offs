//
//  SupabaseRepository.swift
//  ToffData
//
//  Created by 송영모 on 2/4/24.
//

import Foundation

import Supabase
import Dependencies

import Shared

public protocol SupabaseAuthDataSourceInterface {
    var client: SupabaseClient { get set }
    
    func signInWithAppleIdToken(idToken: String) async throws -> Session
}

public class SupabaseAuthDataSource: SupabaseAuthDataSourceInterface {
    public var client = SupabaseClient(
        supabaseURL: URL(string: Environment.supabaseProjectURL)!,
        supabaseKey: Environment.supabaseAPIpublicKey
    )
    
    public func signInWithAppleIdToken(idToken: String) async throws -> Session {
        let session = try await client.auth.signInWithIdToken(
          credentials: OpenIDConnectCredentials(
            provider: .apple,
            idToken: idToken
          )
        )
        return session
    }
}

extension SupabaseAuthDataSource: TestDependencyKey, DependencyKey {
    public static var testValue: SupabaseAuthDataSource = unimplemented()
    public static var liveValue: SupabaseAuthDataSource = .init()
}

public extension DependencyValues {
    var supabaseAuthDataSource: SupabaseAuthDataSource {
        get { self[SupabaseAuthDataSource.self] }
        set { self[SupabaseAuthDataSource.self] = newValue }
    }
}
