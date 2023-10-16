//
//  TagRepository.swift
//  RoffDomainRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftData

public protocol TagRepositoryInterface {
    func fetchTags(descriptor: FetchDescriptor<Tag>) -> [Tag]
    func saveTag(_ tag: TagDTO) -> Tag?
    func updateTag(_ tag: Tag, new newTag: TagDTO) -> Tag?
    func deleteTag(_ tag: Tag) -> Tag?
}

public class TagRepository: TagRepositoryInterface {
    private var context: ModelContext? = StorageContainer.shared.context
    
    public init() { }
    
    public func fetchTags(descriptor: FetchDescriptor<Tag>) -> [Tag] {
        let tags = try? context?.fetch(descriptor)
        return tags ?? []
    }
    
    public func saveTag(_ tag: TagDTO) -> Tag? {
        let tag = tag.toDomain()
        context?.insert(tag)
        return tag
    }
    
    public func updateTag(_ tag: Tag, new newTag: TagDTO) -> Tag? {
        let tag = tag
        tag.hex = newTag.hex
        tag.name = newTag.name
        return tag
    }
    
    public func deleteTag(_ tag: Tag) -> Tag? {
        context?.delete(tag)
        return tag
    }
}
