//
//  CalendarCellView.swift
//  ToffFeature
//
//  Created by 송영모 on 1/13/24.
//

import Foundation
import SwiftUI
import SharedDesignSystem

import Domain

public struct CalendarCellView: View {
    let item: CalendarCellItem
    
    public var body: some View {
        VStack(spacing: 2) {
            headerView
                .padding(.top, 2)
            
            ForEach(item.trades) { trade in
                summarylineView(color: .red, title: "dd", isSelected: true)
            }
            
            Spacer()
        }
        .background(false ? Color.foreground : Color.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
    }
}

extension CalendarCellView {
    private var headerView: some View {
        HStack {
            Spacer()
            
            Text("\(item.date.day)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(false ? Color.background : Color.foreground)
            
            Spacer()
        }
    }
    
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
