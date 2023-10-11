////
////  ToffCalendarView.swift
////  ToffFeatureCalendarInterface
////
////  Created by 송영모 on 10/11/23.
////
//
//import Foundation
//import SwiftUI
//
//import ComposableArchitecture
//
//public struct ToffCalendarView: View {
//    let store: StoreOf<ToffCalendarStore>
//    
//    public init(store: StoreOf<ToffCalendarStore>) {
//        self.store = store
//    }
//    
//    public var body: some View {
//        WithViewStore(self.store, observe: { $0 }) { viewStore in
//            GeometryReader { proxy in
//                ZStack {
//                    headerView(viewStore: viewStore)
//                }
//            }
//        }
//    }
//    
//    private func headerView(viewStore: ViewStoreOf<ToffCalendarStore>) -> some View {
//        Text("")
//    }
//    
//    
//}
