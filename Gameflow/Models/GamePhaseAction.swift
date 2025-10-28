//
//  GamePhaseAction.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//
import Foundation

class GamePhaseAction: Identifiable {
    public let id = UUID()
    private var actionRef: String
    private var name: String
    private var basicActionElements: [BasicActionElement]
    private var actionIcon: String = ""
    
    
    init(actionRef: String, name: String, basicActionElements: [BasicActionElement]) {
        self.actionRef = actionRef
        self.name = name
        self.basicActionElements = basicActionElements
    }
    
    
    init(actionRef: String, name: String, basicActionElements: [BasicActionElement], actionIcon: String) {
        self.actionRef = actionRef
        self.name = name
        self.basicActionElements = basicActionElements
        self.actionIcon = actionIcon
    }
    
    public func setActionIcon(actionIcon: String) {
        self.actionIcon = actionIcon
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func getActionIcon() -> String {
        return self.actionIcon
    }
    
    public func getActionRef() -> String {
        return self.actionRef
    }
    
    public func getBasicActionElements() -> [BasicActionElement] {
        return self.basicActionElements
    }
}


