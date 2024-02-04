//
//  AuthUseCase.swift
//  ToffFeature
//
//  Created by 송영모 on 2/4/24.
//

import Foundation

import Dependencies

import ToffData
import ToffDomain

extension AuthUseCase: TestDependencyKey, DependencyKey {
    public static var testValue: AuthUseCase = unimplemented()
    public static var liveValue: AuthUseCase = .init(
        authRepository: DependencyValues.live.authRepository
    )
}

public extension DependencyValues {
    var authUseCase: AuthUseCase {
        get { self[AuthUseCase.self] }
        set { self[AuthUseCase.self] = newValue }
    }
}
