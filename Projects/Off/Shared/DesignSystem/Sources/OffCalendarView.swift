//
//  OffCalendarView.swift
//  OffSharedDesignSystemInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation
import SwiftUI

import OffSharedFoundationInterface

public struct OffCalendarPreviewItem: Hashable {
    let id: UUID
    let color: Color
    let title: String
    
    var isSelected: Bool
    
    public init(
        id: UUID = .init(),
        color: Color,
        title: String,
        isSelected: Bool = false
    ) {
        self.id = id
        self.color = color
        self.title = title
        self.isSelected = isSelected
    }
}

public struct OffCalendarItem<T: Hashable>: Hashable {
    let id: UUID
    let date: Date
    let previews: [OffCalendarPreviewItem]
    var isSelected: Bool
    
    let data: T
    
    public init(
        id: UUID = .init(), 
        date: Date,
        previews: [OffCalendarPreviewItem],
        isSelected: Bool = false,
        data: T
    ) {
        self.id = id
        self.date = date
        self.previews = previews
        self.isSelected = isSelected
        self.data = data
    }
}

public struct OffCalendarView<T: Hashable>: View {
    let proxy: GeometryProxy
    let items: [OffCalendarItem<T>]
    
    public init(_ proxy: GeometryProxy, items: [OffCalendarItem<T>]) {
        self.proxy = proxy
        self.items = items
    }
    
    public var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
                ForEach(items, id: \.id) { item in
                    OffCalendarItemView(item: item)
                        .frame(height: proxy.size.height * 0.12)
                }
                Spacer()
            }
        }
    }
}

public struct OffCalendarItemView<T: Hashable>: View {
    var item: OffCalendarItem<T>
    
    init(item: OffCalendarItem<T>) {
        self.item = item
    }
    
    public var body: some View {
        VStack(spacing: 2) {
            HStack {
                Spacer()
                
                Text(self.day(from: item.date))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(item.isSelected ? Color.background : Color.foreground)
                
                Spacer()
            }
            .padding(.top, 2)
            
            ForEach(self.item.previews, id: \.id) { previewItem in
                OffCalendarPreviewItemView(item: previewItem)
            }
            
            Spacer()
        }
        .background(item.isSelected ? Color.foreground : Color.background)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8,
                style: .continuous
            )
        )
//        .onTapGesture {
//            viewStore.send(.tapped)
//        }
    }
    
    private func day(from date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        
        return String(describing: "\(components.day ?? 0)")
    }
}

public struct OffCalendarPreviewItemView: View {
    var item: OffCalendarPreviewItem
    
    public var body: some View {
        HStack(spacing: 2) {
            RoundedRectangle(cornerRadius: 3)
                .fill(item.color)
                .frame(width: 2.5, height: 11)
            
            Text(item.title)
                .font(.caption2)
                .fontWeight(.light)
                .foregroundStyle(item.isSelected ? Color.background : Color.foreground)
            
            Spacer()
        }
    }
}
