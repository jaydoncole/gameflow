//
//  GamePhaseAction.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//
import Foundation

class GamePhaseAction: Identifiable {
    public let id = UUID()
    var actionRef: String
    var name: String
    var basicActionElements: [BasicActionElement]
    var actionIcon: String = ""
    var nextScreenType: NextScreenTypes = .NextAction
    var nextScreenId: String = ""
    var lastPlayerNextScreenId: String = "" // If we've reached the last player, defines the next phase we go to
    var displayInScrollView: Bool = false
    
    
    init(actionRef: String, name: String, basicActionElements: [BasicActionElement], nextScreenType: NextScreenTypes, nextScreenId: String) {
        self.actionRef = actionRef
        self.name = name
        self.basicActionElements = basicActionElements
        self.nextScreenType = nextScreenType
        self.nextScreenId = nextScreenId
    }
    
    init (actionRef: String, name: String, basicActionElements: [BasicActionElement], nextScreenType: NextScreenTypes, nextScreenId: String, lastPlayerNextScreenId: String = "", actionIcon: String = "", displayInScrollView: Bool = false)
    {
        self.actionRef = actionRef
        self.name = name
        self.basicActionElements = basicActionElements
        self.nextScreenType = nextScreenType
        self.nextScreenId = nextScreenId
        self.lastPlayerNextScreenId = lastPlayerNextScreenId
        self.actionIcon = actionIcon
        self.displayInScrollView = displayInScrollView

    }
    
    init(actionRef: String, name: String, basicActionElements: [BasicActionElement], nextScreenType: NextScreenTypes, nextScreenId: String, actionIcon: String = "", displayInScrollView: Bool = false) {
        self.actionRef = actionRef
        self.name = name
        self.basicActionElements = basicActionElements
        self.nextScreenType = nextScreenType
        self.nextScreenId = nextScreenId
        self.actionIcon = actionIcon
        self.displayInScrollView = displayInScrollView
    }
}


