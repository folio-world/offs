//
//  ContentView.swift
//  OffFeatureCalendarDemo
//
//  Created by 송영모 on 10/11/23.
//

import SwiftUI

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            VStack {
                Text("DEMO")
            }
        }
    }
}
