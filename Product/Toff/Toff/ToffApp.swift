//
//  ToffApp.swift
//  Toff
//
//  Created by 송영모 on 2/24/24.
//

import SwiftUI
import SwiftData

import ComposableArchitecture

import ToffDomain
import AppTrackingTransparency

@main
struct ToffApp: App {
    var body: some Scene {
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
}
