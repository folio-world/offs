//
//  MyPageMainView.swift
//  ToolinderFeatureMyPageInterface
//
//  Created by 송영모 on 2023/09/11.
//

import SwiftUI
import StoreKit

import ComposableArchitecture

import Shared

public struct MyPageMainView: View {
    let store: StoreOf<MyPageMainStore>
    
    public init(store: StoreOf<MyPageMainStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            List {
                Section {
                    whatIsNewView(viewStore: viewStore)
                    
                    if let url = URL(string: "https://tally.so/r/mJpaR4") {
                        usabilityQuestionnaireView(url: url)
                    }
                }
            }
            .navigationTitle("MyPage")
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
    
    private func whatIsNewView(viewStore: ViewStoreOf<MyPageMainStore>) -> some View {
        Button(action: {
            viewStore.send(.whatIsNewTapped)
        }, label: {
            Label(
                title: { Text("What's New") },
                icon: {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(.blue)
                }
            )
        })
    }
    
    private func usabilityQuestionnaireView(url: URL) -> some View {
        Link(destination: url, label: {
            Label(title: {
                Text("Usability Questionnaire")
            }, icon: {
                Image(systemName: "doc.text.image.fill")
                    .foregroundStyle(.blue)
            })
        })
    }
}
