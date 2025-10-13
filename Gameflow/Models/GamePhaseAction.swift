//
//  GamePhaseAction.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//
import Foundation

class GamePhaseAction: Identifiable {
    public let actionId = UUID()
    private var name: String
    private var helper: String
    private var actionIcon: String = ""
    
    init(name: String, helper: String) {
        self.name = name
        self.helper = helper
    }
    
    init(name: String, helper: String, actionIcon: String) {
        self.name = name
        self.helper = helper
        self.actionIcon = actionIcon
    }
    
    public func setActionIcon(actionIcon: String) {
        self.actionIcon = actionIcon
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getHelper() -> String {
        return self.helper
    }
    
    public func getActionIcon() -> String {
        return self.actionIcon
    }
}


