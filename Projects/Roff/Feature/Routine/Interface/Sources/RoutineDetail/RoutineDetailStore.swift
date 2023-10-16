//
//  RoutineDetailStore.swift
//  RoffFeatureRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation

import ComposableArchitecture

import RoffDomainRoutineInterface

public struct RoutineDetailStore: Reducer {
    public init() {}
    
    public struct State: Equatable {
        public var mode: EditMode
        public var routine: Routine?
        
        @BindingState public var title: String = ""
        
        public init(
            mode: EditMode = .add,
            routine: Routine? = nil
        ) {
            self.mode = mode
            self.routine = routine
        }
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        
        case onAppear
        
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
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
                
            default:
                return .none
            }
        }
    }
}
