//
//  RoutineRepository.swift
//  RoffDomainRoutineInterface
//
//  Created by 송영모 on 10/16/23.
//

import Foundation
import SwiftData

public protocol RoutineRepositoryInterface {
    func fetchRoutines(descriptor: FetchDescriptor<Routine>) -> [Routine]
    func saveRoutine(_ routine: RoutineDTO) -> Routine
    func updateRoutine(_ routine: Routine, new newRoutine: RoutineDTO) -> Routine
    func deleteRoutine(_ routine: Routine) -> Routine
}

public class RoutineRepository: RoutineRepositoryInterface {
    private var context: ModelContext? = StorageContainer.shared.context
    
    public init() { }
    
    public func fetchRoutines(descriptor: FetchDescriptor<Routine>) -> [Routine] {
        let routines = try? context?.fetch(descriptor)
        return routines ?? []
    }
    
    public func saveRoutine(_ routine: RoutineDTO) -> Routine {
        let routine = routine.toDomain()
        context?.insert(routine)
        return routine
    }
    
    public func updateRoutine(_ routine: Routine, new newRoutine: RoutineDTO) -> Routine {
        let routine = routine
        routine.title = newRoutine.title
        routine.startDate = newRoutine.startDate
        routine.endDate = newRoutine.endDate
        routine.doneDates = newRoutine.doneDates
        return routine
    }
    
    public func deleteRoutine(_ routine: Routine) -> Routine {
        context?.delete(routine)
        return routine
    }
}
