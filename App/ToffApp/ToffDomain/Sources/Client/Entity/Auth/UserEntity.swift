//
//  UserEntity.swift
//  ToffDomain
//
//  Created by 송영모 on 2/4/24.
//

import Foundation

public struct UserEntity {
    public let id: UUID
    public let provider: AuthProvider
    
    public init(id: UUID, provider: AuthProvider) {
        self.id = id
        self.provider = provider
    }
}
