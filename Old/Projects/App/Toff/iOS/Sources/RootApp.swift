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

import ToffDomain
import AppTrackingTransparency

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(initialState: RootStore.State()) {
                    RootStore()
                } withDependencies: {
                    $0.prepareLive()
                }
            )
            .modelContainer(for: [
                Ticker.self,
                Trade.self,
                Tag.self
            ])
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
                })
            }
        }
    }
}
