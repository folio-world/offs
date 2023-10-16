//
//  RoutineClient.swift
//  RoffDomainRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftData

import ComposableArchitecture

public struct RoutineClient {
    public static let routineRepository: RoutineRepositoryInterface = RoutineRepository()
    
    public var fetchRoutines: () -> [Routine]
    public var saveRoutine: (RoutineDTO) -> Routine?
    public var updateRoutine: (Routine, RoutineDTO) -> Routine?
    public var deleteRoutine: (Routine) -> Routine?
        
    public init(
        fetchRoutines: @escaping () -> [Routine],
        saveRoutine: @escaping (RoutineDTO) -> Routine?,
        updateRoutine: @escaping (Routine, RoutineDTO) -> Routine?,
        deleteRoutine: @escaping (Routine) -> Routine?
    ) {
        self.fetchRoutines = fetchRoutines
        self.saveRoutine = saveRoutine
        self.updateRoutine = updateRoutine
        self.deleteRoutine = deleteRoutine
    }
}

extension RoutineClient: TestDependencyKey {
    public static var previewValue: RoutineClient = Self(
        fetchRoutines: { return [] },
        saveRoutine: { _ in return nil },
        updateRoutine: { _, _ in return nil },
        deleteRoutine: { _ in return nil }
    )
    
    public static var testValue = Self(
        fetchRoutines: unimplemented("\(Self.self).fetchRoutines"),
        saveRoutine: unimplemented("\(Self.self).saveRoutine"),
        updateRoutine: unimplemented("\(Self.self).updateRoutine"),
        deleteRoutine: unimplemented("\(Self.self).deleteRoutine")
    )
}

public extension DependencyValues {
    var routineClient: RoutineClient {
        get { self[RoutineClient.self] }
        set { self[RoutineClient.self] = newValue }
    }
}

extension RoutineClient: DependencyKey {
    public static var liveValue = RoutineClient(
        fetchRoutines: { routineRepository.fetchRoutines(descriptor: .init()) },
        saveRoutine: routineRepository.saveRoutine,
        updateRoutine: routineRepository.updateRoutine(_:new:),
        deleteRoutine: routineRepository.deleteRoutine
    )
}
