//
//  TagClient.swift
//  ToolinderDomainTradeInterface
//
//  Created by 송영모 on 2023/10/01.
//

import Foundation
import SwiftData

import ComposableArchitecture

public struct TagClient {
    public static let tagRepository: TagRepositoryInterface = TagRepository()
    
    public var fetchTags: () -> [Tag]
    public var saveTag: (TagDTO) -> Tag?
    public var updateTag: (Tag, TagDTO) -> Tag?
    public var deleteTag: (Tag) -> Tag?
    
    public init(
        fetchTags: @escaping () -> [Tag],
        saveTag: @escaping (TagDTO) -> Tag?,
        updateTag: @escaping (Tag, TagDTO) -> Tag?,
        deleteTag: @escaping (Tag) -> Tag?
    ) {
        self.fetchTags = fetchTags
        self.saveTag = saveTag
        self.updateTag = updateTag
        self.deleteTag = deleteTag
    }
}

extension TagClient: TestDependencyKey {
    public static var previewValue: TagClient = Self(
        fetchTags: { return [] },
        saveTag: { _ in return nil },
        updateTag: { _, _ in return nil },
        deleteTag: { _ in return nil }
    )
    
    public static var testValue = Self(
        fetchTags: unimplemented("\(Self.self).fetchTags"),
        saveTag: unimplemented("\(Self.self).saveTag"),
        updateTag: unimplemented("\(Self.self).updateTag"),
        deleteTag: unimplemented("\(Self.self).deleteTag")
    )
}

public extension DependencyValues {
    var tagClient: TagClient {
        get { self[TagClient.self] }
        set { self[TagClient.self] = newValue }
    }
}

extension TagClient: DependencyKey {
    public static var liveValue = TagClient(
        fetchTags: { tagRepository.fetchTags(descriptor: .init()) },
        saveTag: tagRepository.saveTag,
        updateTag: tagRepository.updateTag(_:new:),
        deleteTag: tagRepository.deleteTag
    )
}
