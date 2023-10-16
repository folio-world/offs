//
//  RoutineDetailView.swift
//  RoffFeatureRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct RoutineDetailView: View {
    let store: StoreOf<RoutineDetailStore>
    
    public init(store: StoreOf<RoutineDetailStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("Routine Detail")
        }
    }
}
