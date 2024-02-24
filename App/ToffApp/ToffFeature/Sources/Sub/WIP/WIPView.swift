//
//  WIPView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/27/24.
//

import Foundation

import SwiftUI

import ComposableArchitecture

import ToffDomain
import SharedDesignSystem

public struct WIPView: View {
    typealias State = WIPStore.State
    typealias Action = WIPStore.Action
    
    let store: StoreOf<WIPStore>
    
    public init(store: StoreOf<WIPStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("🚧 WIP 🚧")
        }
        .onAppear { store.send(.onAppear) }
    }
}

