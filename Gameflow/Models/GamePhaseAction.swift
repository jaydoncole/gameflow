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
    private var nextScreenType: NextScreenTypes = .NextAction
    private var nextScreenId: String = ""
    private var displayInScrollView: Bool = false
    
    
    init(actionRef: String, name: String, basicActionElements: [BasicActionElement], nextScreenType: NextScreenTypes, nextScreenId: String, displayInScrollView: Bool = false) {
        self.actionRef = actionRef
        self.name = name
        self.basicActionElements = basicActionElements
        self.nextScreenType = nextScreenType
        self.nextScreenId = nextScreenId
        self.displayInScrollView = displayInScrollView
    }
    
    
    init(actionRef: String, name: String, basicActionElements: [BasicActionElement], nextScreenType: NextScreenTypes, nextScreenId: String, actionIcon: String, displayInScrollView: Bool = false) {
        self.actionRef = actionRef
        self.name = name
        self.basicActionElements = basicActionElements
        self.nextScreenType = nextScreenType
        self.nextScreenId = nextScreenId
        self.actionIcon = actionIcon
        self.displayInScrollView = false
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
    
    public func getNextScreenType() -> NextScreenTypes {
        return nextScreenType
    }
    
    
    public func setNextScreenId(screenId: String) {
        self.nextScreenId = screenId
    }
    
    public func getNextScreenId() -> String {
        return nextScreenId
    }
    
    public func getDisplayInScrollView() -> Bool {
        return displayInScrollView
    }
}


