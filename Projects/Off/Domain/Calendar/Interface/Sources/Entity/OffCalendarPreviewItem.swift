//
//  OffCalendarPreviewEntity.swift
//  OffDomainCalendarInterface
//
//  Created by 송영모 on 10/11/23.
//

import Foundation
import SwiftUI

public struct OffCalendarPreviewItem: Equatable, Identifiable {
    public let id: UUID
    public let color: Color
    public let title: String
    public var isSelected: Bool
    
    public init(
        id: UUID,
        color: Color,
        title: String,
        isSelected: Bool
    ) {
        self.id = id
        self.color = color
        self.title = title
        self.isSelected = isSelected
    }
}
