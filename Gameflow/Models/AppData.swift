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
    var showNextPhaseButton: Bool = false
    var showNextActionButton: Bool = false
    var goToNextAction: Bool = false
    var goToNextPhase: Bool = false
    var goToNextPlayer: Bool = false
    var playerEliminated: Bool = false
    var customActionButtonListener: String = "" // If we have "branching actions" buttons, this will allow us to listen for those clicks to be handled in the PhaseView

    public func ResetGameState() {
        currentGame = .Unset
        selectedPlayers = []
        currentPlayer = 0
        gamePhases = []
        currentPhase = 0
        currentAction = 0
        resetGame = false
    }
    
    public func ToggleNextActionButton() {
        showNextActionButton = true
        showNextPhaseButton = false
    }
    
    public func ToggleNextPhaseButton() {
        showNextActionButton = false
        showNextPhaseButton = true
    }
    
    public func DetermineNextPhaseActionButton() {
        let onLastAction = currentGame.gamePhases[currentPhase].getPhaseActions().count == currentAction + 1
        onLastAction ? ToggleNextPhaseButton() : ToggleNextActionButton()
    }
    
    public func HideProgressionButtons() {
        showNextActionButton = false
        showNextPhaseButton = false
    }
    
    public func GetCurrentPhase() -> GamePhase {
        return currentGame.gamePhases[currentPhase]
    }
    
    public func GetCurrentPlayer() -> PlayerProfile {
        return selectedPlayers[currentPlayer]
    }
    
    public func GetCurrentAction() -> GamePhaseAction {
        return currentGame.gamePhases[currentPhase].getPhaseAction(index: currentAction)
    }
}
