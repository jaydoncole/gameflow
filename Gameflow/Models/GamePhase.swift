//
//  GamePhase.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//
import Foundation

class GamePhase: CustomStringConvertible, Identifiable {
    public let id = UUID()
    public let phaseId: String
    private var title: String
    private var details: String
    private var phaseIcon: String = ""
    private var phaseActions: [GamePhaseAction] = []
    
    public var description: String {
        return title
    }
    
    init(phaseId: String, title: String, details: String, phaseActions: [GamePhaseAction]) {
        self.phaseId = phaseId
        self.title = title
        self.details = details
        self.phaseActions = phaseActions
    }

    init(phaseId: String, title: String, details: String, phaseIcon: String, phaseActions: [GamePhaseAction]) {
        self.phaseId = phaseId
        self.title = title
        self.details = details
        self.phaseIcon = phaseIcon
        self.phaseActions = phaseActions
    }
    
    
    public func setPhaseIcon(phaseIcon: String) {
        self.phaseIcon = phaseIcon
    }
    
    public func appendPhaseAction(phaseAction: GamePhaseAction) {
        self.phaseActions.append(phaseAction)
    }
    
    public func getTitle() -> String {
        return self.title
    }
    
    public func getDescription() -> String {
        return self.details
    }
    
    public func getPhaseIcon() -> String {
        return self.phaseIcon
    }
    
    public func getPhaseActions() -> [GamePhaseAction]  {
        return self.phaseActions
    }
    
    public func getPhaseAction(index: Int) -> GamePhaseAction {
        return self.phaseActions[index]
    }
}
