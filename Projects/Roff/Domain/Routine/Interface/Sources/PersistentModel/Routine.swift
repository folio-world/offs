//
//  Routine.swift
//  RoffDomainRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftData

@Model
public class Routine {
    @Attribute(.unique) public let id: UUID = UUID()
    
    public var title: String = ""
    public var startDate: Date = Date.now
    public var endDate: Date = Date.now
    public var doneDates: [Date] = []
    
    @Relationship(inverse: \Tag.routines) public var tags: [Tag]? = []
    
    public init(
        id: UUID = .init(),
        title: String = "",
        startDate: Date = .now,
        endDate: Date = .now,
        doneDates: [Date] = [],
        tags: [Tag]
    ) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.doneDates = doneDates
        self.tags = tags
    }
    
    func toDTO() -> RoutineDTO {
        return RoutineDTO(
            id: id,
            title: title,
            startDate: startDate,
            endDate: endDate,
            doneDates: doneDates,
            tags: tags?.map { $0.toDTO() } ?? []
        )
    }
}

public struct RoutineDTO {
    public let id: UUID
    public var title: String
    public var startDate: Date
    public var endDate: Date
    public var doneDates: [Date]
    public var tags: [TagDTO]
    
    init(
        id: UUID = UUID(),
        title: String,
        startDate: Date,
        endDate: Date,
        doneDates: [Date],
        tags: [TagDTO]
    ) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.doneDates = doneDates
        self.tags = tags
    }
    
    func toDomain() -> Routine {
        return Routine(
            id: id,
            title: title,
            startDate: startDate,
            endDate: endDate,
            doneDates: doneDates,
            tags: tags.map { $0.toDomain() }
        )
    }
}
