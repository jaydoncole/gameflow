//
//  PhaseHelperMethods.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/19/25.
//

import SwiftUI

class PhaseHelperMethods {
    public static func mapPhaseIdToIndex(gamePhases: [GamePhase], phaseId: String) -> Int {
        var index = 0
        for gamePhase in gamePhases {
            if gamePhase.phaseId == phaseId {
                return index
            }
            index += 1
        }
        return -1
    }
    
    
    public static func mapIndexToPhaseId(gamePhases: [GamePhase], index: Int) -> String {
        if gamePhases.indices.contains(index) {
            return gamePhases[index].phaseId
        }
        return "Phase Not Found"
    }
    
    
    public static func mapActionRefToIndex(phase: GamePhase, actionRef: String) -> Int {
        var index = 0
        for gamePhaseAction in phase.phaseActions {
            if gamePhaseAction.actionRef == actionRef {
                return index
            }
            index += 1
        }
        return -1
    }
    
    
    public static func mapIndexToActionRef(phase: GamePhase, index: Int) -> String {
        let phaseActions = phase.phaseActions
        if phaseActions.indices.contains(index) {
            return phaseActions[index].actionRef
        }
        return "Action Not Found"
    }
    
    public static func FilterBasicActionElementsByGroupName(groupName: String, actionElements: [BasicActionElement]) -> [BasicActionElement] {
        let filteredElements = actionElements.filter({
            $0.groupName == groupName
        })
        return filteredElements
    }
}

