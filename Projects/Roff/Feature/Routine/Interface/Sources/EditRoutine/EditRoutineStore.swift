//
//  EditRoutineStore.swift
//  RoffFeatureRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import RoffDomainRoutineInterface
import RoffShared

public struct EditRoutineStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        var mode: OffEditMode
        var routine: Routine?
        
        @BindingState var title: String = ""
        @BindingState var startDate: Date = .now
        @BindingState var endDate: Date = .now
        @BindingState var color: Color = .foreground
        
        var tagItems: IdentifiedArrayOf<TagItemCellStore.State> = []
        @PresentationState var selectTag: SelectTagStore.State?
        
        public init(
            mode: OffEditMode = .add,
            routine: Routine? = nil
        ) {
            self.mode = mode
            self.routine = routine
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
        case editButtonTapped(OffEditMode.Action)
        case tagButtonTapped
        case saveButtonTapped
        
        case tagItems(id: TagItemCellStore.State.ID, action: TagItemCellStore.Action)
        case selectTag(PresentationAction<SelectTagStore.Action>)
        case delegate(Delegate)
        
        public enum Alert: Equatable {
            case confirmDeletion
        }
        
        public enum Delegate: Equatable {
            case cancle
            case delete
        }
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .onAppear:
                return .none
                
            case let .editButtonTapped(action):
                return .none
                
            case .tagButtonTapped:
                state.selectTag = .init(selectedTags: state.routine?.tags ?? [])
                return .none
                
            case .selectTag(.dismiss):
                state.selectTag = nil
                return .none
                
            default:
                return .none
            }
        }
        .ifLet(\.$selectTag, action: /Action.selectTag) {
            SelectTagStore()
        }
    }
}
