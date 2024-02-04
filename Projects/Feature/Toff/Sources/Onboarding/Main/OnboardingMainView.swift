//
//  OnboardingMainView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import SwiftUI

import ComposableArchitecture

import ToffDomain
import SharedDesignSystem

public struct OnboardingMainView: View {
    typealias State = OnboardingMainStore.State
    typealias Action = OnboardingMainStore.Action
    
    let store: StoreOf<OnboardingMainStore>
    
    public init(store: StoreOf<OnboardingMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("onbarding main")
        }
        .onAppear { store.send(.onAppear) }
    }
}
