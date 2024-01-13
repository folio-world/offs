//
//  CalendarCellView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/13/24.
//

import Foundation
import SwiftUI

import Domain

public struct CalendarCellView: View {
    let item: CalendarCellItem
    
    public var body: some View {
        VStack {
            ForEach(item.trades) { trade in
                summarylineView(color: .red, title: "hi", isSelected: true)
            }
        }
    }
}

extension CalendarCellView {
    private func summarylineView(color: Color, title: String, isSelected: Bool) -> some View {
        HStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 3)
                .fill(color)
                .frame(width: 2.5, height: 11)
            
            Text(title)
                .font(.caption2)
                .fontWeight(.light)
                .foregroundStyle(isSelected ? Color.background : Color.foreground)
            
            Spacer()
        }
    }
}
