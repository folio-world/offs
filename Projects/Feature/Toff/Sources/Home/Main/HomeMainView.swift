//
//  CalendarMainView.swift
//  ToolinderFeatureCalendarInterface
//
//  Created by 송영모 on 2023/08/29.
//

import SwiftUI
import SwiftData
import Combine
import ComposableArchitecture

import Domain
import SharedDesignSystem

public struct HomeMainView: View {
    typealias State = HomeMainStore.State
    typealias Action = HomeMainStore.Action
    
    let store: StoreOf<HomeMainStore>
    
    public init(store: StoreOf<HomeMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            Text("comming soon!")
        }
    }
}
