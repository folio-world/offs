//
//  EditTagStore.swift
//  ToolinderFeatureTradeInterface
//
//  Created by 송영모 on 2023/10/02.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import RoffDomain
import RoffShared

public struct EditTagStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var mode: OffEditMode
        var tag: Tag?
        
        @BindingState var name: String = ""
        @BindingState var color: Color = .foreground
        
        public init(
            mode: OffEditMode,
            tag: Tag? = nil
        ) {
            self.mode = mode
            self.tag = tag
            
            if mode == .edit {
                self.name = tag?.name ?? ""
                self.color = Color(hex: tag?.hex ?? "")
            }
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case editButtonTapped(OffEditMode.Action)
        case saveButtonTapped
        
        case delegate(Delegate)
        
        public enum Delegate: Equatable {
            case cancle
            case save(Tag)
            case delete(Tag)
        }
    }
    
    @Dependency(\.tagClient) var tagClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            case let .editButtonTapped(action):
                switch action {
                case .dismiss:
                    return .send(.delegate(.cancle))
                case .delete:
                    if let tag = state.tag, let deletedTag = tagClient.deleteTag(tag) {
                        return .send(.delegate(.delete(deletedTag)))
                    }
                default: break
                }
                return .none
                
            case .saveButtonTapped:
                guard state.name != "" else { return .none }
                if let tag = tagClient.saveTag(.init(hex: state.color.toHex(), name: state.name)) {
                    return .send(.delegate(.save(tag)))
                }
                return .none
                
            default:
                return .none
            }
        }
    }
}
