//
//  GamePhase.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//
import Foundation

class GamePhase: CustomStringConvertible, Identifiable {
    public let id = UUID()
    var phaseId: String
    var title: String
    var description: String
    var phaseIcon: String = ""
    var phaseActions: [GamePhaseAction] = []
    
    
    init(phaseId: String, title: String, details: String, phaseActions: [GamePhaseAction]) {
        self.phaseId = phaseId
        self.title = title
        self.description = details
        self.phaseActions = phaseActions
    }

    init(phaseId: String, title: String, details: String, phaseIcon: String, phaseActions: [GamePhaseAction]) {
        self.phaseId = phaseId
        self.title = title
        self.description = details
        self.phaseIcon = phaseIcon
        self.phaseActions = phaseActions
    }
    
    
    public func appendPhaseAction(phaseAction: GamePhaseAction) {
        self.phaseActions.append(phaseAction)
    }
    
    public func getPhaseActionByActionRef(actionRef: String) -> GamePhaseAction {
        for action in phaseActions {
            if actionRef == action.actionRef {
                return action
            }
        }
        // Shouldn't get here, but just in case... 
        return self.phaseActions[0]
    }
}
