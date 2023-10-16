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
            case saved(Routine)
            case delete
        }
    }
    
    @Dependency(\.routineClient) var routineClient
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .onAppear:
                return .none
                
            case .editButtonTapped:
                return .none
                
            case .tagButtonTapped:
                state.selectTag = .init(selectedTags: state.routine?.tags ?? [])
                return .none
                
            case .saveButtonTapped:
                if let routineDTO = validateRoutineDTO(
                    title: state.title,
                    startDate: state.startDate,
                    endDate: state.endDate,
                    doneDates: [],
                    tags: state.tagItems.map(\.tag).map { $0.toDTO() }
                ), let routine = routineClient.saveRoutine(routineDTO) {
                    return .send(.delegate(.saved(routine)))
                }
                return .none
                
            case let .selectTag(.presented(.delegate(action))):
                state.selectTag = nil
                switch action {
                case let .selected(tags):
                    state.tagItems = .init(
                        uniqueElements: tags.map { tag in
                            return .init(mode: .select, tag: tag)
                        }
                    )
                    return .none
                case .deleted: return .none
                }
                
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
    
    private func validateRoutineDTO(
        title: String,
        startDate: Date,
        endDate: Date,
        doneDates: [Date],
        tags: [TagDTO]
    ) -> RoutineDTO? {
        guard 
            !title.isEmpty,
            startDate < endDate
        else {
            return nil
        }
        return .init(
            title: title,
            startDate: startDate,
            endDate: endDate,
            doneDates: doneDates,
            tags: tags
        )
    }
}
