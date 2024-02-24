//
//  AuthRepository.swift
//  ToffData
//
//  Created by 송영모 on 2/4/24.
//

import Foundation

import Auth
import Supabase
import Dependencies

public protocol AuthRepositoryInterface {
    @discardableResult func signIn(from appleIdToken: String) async throws -> Session
    @discardableResult func session() async throws -> Session
    func refreshSession() async throws -> Void
    func user() async throws -> User
}

public class AuthRepository: AuthRepositoryInterface {
    public let client = SupabaseClientProvider.client
    
    public init() { }
    
    public func signIn(from appleIdToken: String) async throws -> Session {
        return try await client.auth.signInWithIdToken(
            credentials: .init(
                provider: .apple,
                idToken: appleIdToken
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

extension User {
    func toDomain() -> UserEntity {
        return .init(id: self.id, provider: .apple)
    }
}

