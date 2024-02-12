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
import AuthenticationServices
import ToffDomain

public protocol SupabaseAuthDataSourceInterface {
    var client: SupabaseClient { get set }
    
    func signIn(from appleIdToken: String) async throws -> Session
    func session() async throws -> Session
    func refreshSession() async throws -> Void
    func user() async throws -> User
}

public class SupabaseAuthDataSource: SupabaseAuthDataSourceInterface {
    public var client = SupabaseClient(
        supabaseURL: URL(string: Environment.supabaseProjectURL)!,
        supabaseKey: Environment.supabaseAPIpublicKey
    )
    
    public func signIn(from appleIdToken: String) async throws -> Session {
        return try await client.auth.signInWithIdToken(
            credentials: .init(
                provider: .apple,
                idToken: appleIdToken,
                nonce: nonce()
            )
        )
    }
    
    public func session() async throws -> Session {
        return try await client.auth.session
    }
    
    public func refreshSession() async throws -> Void {
        try await client.auth.refreshSession()
    }
    
    public func user() async throws -> User {
        try await client.auth.user()
    }
    
    private func nonce(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
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

public extension User {
    func toDomain() -> UserEntity {
        return .init(id: self.id, provider: .apple)
    }
}
