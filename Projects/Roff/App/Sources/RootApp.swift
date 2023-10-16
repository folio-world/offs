//
//  RootApp.swift
//  Dying
//
//  Created by 송영모 on 2023/07/19.
//  Copyright © 2023 folio.world. All rights reserved.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

import RoffDomain

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootStore.State()) {
                    RootStore()
                        ._printChanges()
                }
            )
            .modelContainer(for: [
                Routine.self,
                Tag.self
            ])
            .onAppear(perform: UIApplication.shared.hideKeyboard)
        }
    }
}
