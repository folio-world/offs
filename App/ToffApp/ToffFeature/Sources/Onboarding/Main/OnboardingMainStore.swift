//
//  OnboardingMainStore.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import ComposableArchitecture

import ToffDomain
import OffSharedDesignSystem

public struct OnboardingMainStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public let id: UUID

        public init(
            id: UUID = .init()
        ) {
            self.id = id
        }
    }
    
    public enum Action: Equatable {
        case onAppear
        
        public enum Delegate: Equatable {
            
        }
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}
