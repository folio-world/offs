//
//  EditRoutineView.swift
//  RoffFeatureRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftUI

import ComposableArchitecture

public struct EditRoutineView: View {
    let store: StoreOf<EditRoutineStore>
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("Edit Routine")
        }
    }
}
