//
//  AuthRepositoryInterface.swift
//  ToffData
//
//  Created by 송영모 on 2/4/24.
//

import Foundation

import Auth

public protocol AuthRepositoryInterface {
    func signIn(from idToken: String) async throws -> Session
    func refresh() async throws -> Void
    func user() async throws -> UserEntity
}
