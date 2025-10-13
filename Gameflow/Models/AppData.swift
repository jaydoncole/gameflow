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
    
    /* Flag to trigger reset game */
    var resetGame = false
    
    /* Flag to show the game over dialog*/
    var showGameOverDialog = false
    
    /* In games where players can be eliminated, we need to know if we should show all players eliminated dialoge*/
    var showAllPlayersDead = false
    
    var showPlayerEliminatedMessage = false
    
    /* Phases Navigation states */
    var showNextPhaseButton: Bool = false
    var showNextActionButton: Bool = false
    var goToNextAction: Bool = false
    var goToNextPhase: Bool = false
    var playerEliminated: Bool = false

    public func ResetGameState() {
        currentGame = .Unset
        selectedPlayers = []
        currentPlayer = 0
        gamePhases = []
        currentPhase = 0
        resetGame = false
    }
}
