//
//  EmptyView.swift
//  ToffFeatureTradeInterface
//
//  Created by 송영모 on 11/5/23.
//

import SwiftUI

public struct EmptyGuideView: View {
    public var action: () -> ()
    
    public init(action: @escaping () -> Void) {
        self.action = action
    }
    
    public var body: some View {
        HStack {
            VStack {
                Text("👋")
                    .padding(.vertical)
                
                Text("Welcome!")
                    .font(.caption)
                
                Text("Please add ticker")
                    .font(.caption)
            }
            .padding()
        }
        .frame(minWidth: 100, minHeight: 100)
        .padding(10)
        .background(.ultraThickMaterial)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
        .onTapGesture {
            action()
        }
    }
}
