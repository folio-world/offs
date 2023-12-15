//
//  OffCalendarView.swift
//  SharedDesignSystem
//
//  Created by 송영모 on 12/16/23.
//

import SwiftUI

public struct OffCalendarItem {
    
}

public struct OffCalendarView: View {
    let item: OffCalendarItem

    public var body: some View {
        LazyVGrid(
            columns: .init(repeating: .init(.flexible()), count: 7), 
            spacing: .zero
        ) {
            
        }
    }
}
