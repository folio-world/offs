//
//  ContentView.swift
//  OffFeatureCalendarDemo
//
//  Created by 송영모 on 10/11/23.
//

import SwiftUI

import ComposableArchitecture

import OffFeatureCalendarInterface
import OffFeatureCalendar

@main
struct RootApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            VStack {
                OffCalendarView<Int>(
                    store: Store(
                        initialState: OffCalendarStore<Int>.State(
                            offCalendars: .init(
                                uniqueElements: Date.now.allDatesInMonth().map {
                                    .init(
                                        date: $0,
                                        isSelected: false,
                                        offCalendarPreview: .init(
                                            uniqueElements: [
                                                .init(title: "test", color: .pink)
                                            ]
                                        )
                                    )
                                }
                            )
                        )
                    ) {
                        OffCalendarStore()._printChanges()
                    }
                )
            }
        }
    }
}
