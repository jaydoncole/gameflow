//
//  AppData.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/28/25.
//

import Observation
import SwiftUI

@Observable class AppData: @unchecked Sendable {
    var viewPath = NavigationPath()
    
    /* Holds the currently selected game */
    var currentGame = Games.Unset
    
    /* Players selected for hte game */
    var selectedPlayers: [PlayerProfile] = []
    
    var currentPlayer: Int = 0
   
    /* List of phases for the current active game*/
    var gamePhases: [GamePhase] = []
    
    /* Stores the phase that the game current on*/
    var currentPhase: Int = 0
    
    /* Stores the Action that the game is currently on*/
    var currentAction: Int = 0
    
    /* Flag to trigger reset game */
    var resetGame = false
    
    /* Flag to show the game over dialog*/
    var showGameOverDialog = false
    
    /* In games where players can be eliminated, we need to know if we should show all players eliminated dialoge*/
    var showAllPlayersDead = false
    
    /* Triggers the Player Eliminated Message */
    var showPlayerEliminatedMessage = false
    
    /* Holds the navigation title for the current View */
    var navigationTitle: String = ""
    
    /* Phases Navigation states */
    var showProgressionButtons: Bool = true
    var goToNextAction: Bool = false
    var goToNextPhase: Bool = false
    var goToNextPlayer: Bool = false
    var playerEliminated: Bool = false
    var customActionButtonListener: String = "" // If we have "branching actions" buttons (multiple buttons in an Actionview that will go into separate flows), this will allow us to listen for those clicks to be handled in the PhaseView
    
    /* In some cases we may have variables in instrcructions, we'll keep an array values to search for in strings, and the replacement */
    var valueReplacements: [ValueReplacement] = []
    
    // In some cases we need to override what screen will be displayed next, this will store the string of the next screen reference id
    var nextScreenOverride: String = ""
    
    // TODO: There may be optional rules or expansions that modify the game's flow, we'll store any selected options/expansions here
    var optionalRulels: [String] = []
    
    // Some phases or menu options can provide heloper sheet for rule references, this stores the data to be displayed if it is opened
    var helperSheetContent: [BasicActionElement] = []
    var displayHelperSheet: Bool = false
    

    public func ResetGameState() {
        currentGame = .Unset
        selectedPlayers = []
        currentPlayer = 0
        gamePhases = []
        currentPhase = 0
        currentAction = 0
        valueReplacements = []
        resetGame = false
    }
    
    public func GetCurrentPhase() -> GamePhase {
        return currentGame.gamePhases[currentPhase]
    }
    
    public func GetCurrentPlayer() -> PlayerProfile {
        return selectedPlayers[currentPlayer]
    }
    
    public func GetCurrentAction() -> GamePhaseAction {
        return currentGame.gamePhases[currentPhase].phaseActions[currentAction]
    }
    
    public func GoToPhaseAction(phaseId: String, actionId: String) {
        var phaseCounter = 0
        var actionCounter = 0
        outerLoop: for gamePhase in currentGame.gamePhases {
            if(gamePhase.phaseId == phaseId) {
                for phaseAction in gamePhase.phaseActions {
                    if(phaseAction.actionRef == actionId) {
                        currentPhase = phaseCounter
                        currentAction = actionCounter
                        print("currentPhase: \(currentPhase), currentAction: \(currentAction)")
                        break outerLoop
                    }
                    actionCounter += 1
                }
            }
            phaseCounter += 1
        }
    }
    
    public func GoToPhaseAction(phaseId: String) {
        var phaseCounter = 0
        for gamePhase in currentGame.gamePhases {
            if(gamePhase.phaseId == phaseId) {
                currentPhase = phaseCounter
                currentAction = 0
                break;
            }
            phaseCounter += 1
        }
    }
    
    public func GoToPhaseAction(actionId: String) {
        var actionCounter = 0
        for phaseAction in GetCurrentPhase().phaseActions {
            if(phaseAction.actionRef == actionId) {
                currentAction = actionCounter
                break;
            }
            actionCounter += 1
        }
    }
    
    public func GoToNextScreen() {
        var nextScreenId = ""
        if nextScreenOverride.count > 0 {
            nextScreenId = nextScreenOverride
            nextScreenOverride = ""
        } else {
            nextScreenId = GetCurrentAction().nextScreenId
        }
        switch GetCurrentAction().nextScreenType {
            case .NextAction:
                GoToPhaseAction(actionId: nextScreenId)
            case .NextPhase:
                GoToPhaseAction(phaseId: nextScreenId)
            case .NextPlayer:
                if GetCurrentAction().lastPlayerNextScreenId.count > 0 && currentPlayer == selectedPlayers.count - 1  {
                    GoToPhaseAction(phaseId: GetCurrentAction().lastPlayerNextScreenId)
                } else {
                    GoToPhaseAction(phaseId: nextScreenId)
                }
                SetNextPlayer()
            default:
                print ("Invalid Screen Type")
        }
    }
    
    
    public func SetNextPlayer() {
        let nextPlayer = PlayerHelperMethods.getNextLivePlayer(currentPlayerIndex: currentPlayer, selectedPlayers: selectedPlayers)
        if nextPlayer == -1 {
            showAllPlayersDead = true
        } else {
            currentPlayer = nextPlayer
        }
    }
}
