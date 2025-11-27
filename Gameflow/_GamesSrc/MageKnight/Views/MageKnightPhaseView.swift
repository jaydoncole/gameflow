//
//  MageKnightGamePhases.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/12/25.
//

import SwiftUI

struct MageKnightPhaseView: View {
    @Environment(AppData.self) private var appData: AppData
    
    @State var selectedScenario: MageKnightScenario = MageKnightScenario()
    @State var usingDummyPlayer: Bool = false
    @State var firstRound: Bool = true
    
    @State var endOfRoundAnnounced: Bool = false
    @State var endOfRoundPlayer: Int? = nil
    @State var endOfRoundStartedLastCycle: Bool = false
    
    
    var body: some View {
        VStack {
            Text(appData.GetCurrentPhase().description)
            switch appData.GetCurrentPhase().phaseId {
                case "game_setup":
                // Game setup methods moved to MageKnightGameSetupView
                    MageKnightGameSetupView(selectedScenario: $selectedScenario, usingDummyPlayer: $usingDummyPlayer)
                case "prepare_round":
                    PhaseTypeSequentialActionView()
                case "choose_tactic_cards":
                    SetPlayerOrderView(helperText: "Choose Tactic Cards\n\n-Player with the lowest Fame picks first, followed by second lowest, etc. In case of tie, the player whos Round Order token is in a lower position picks first.\n\nFollow any \"When you take this Tactic\" instructions\n\nRearrange the Round Order tokens according to the Tactic numer of each player, such that the lowest Tactic number is on top.\n\n")
                case "player_actions":
                    // Player Action methods moved to MageKnightPlayerActionsView
                    MageKnightPlayerActionsView(endOfRoundAnnounced: $endOfRoundAnnounced)
                case "check_for_end_game":
                    Text("Check for Game End!")
                default:
                    Text("No Phase Selected!")
            }
            Spacer()
        }
        .padding()
        .onChange(of: appData.goToNextPhase) {
            NextPhaseHandler()
        }
        .onChange(of: appData.goToNextAction) {
            NextActionHandler()
        }
        .onChange(of: appData.goToNextPlayer) {
            NextPlayerHandler()
        }
        .onChange(of: appData.customActionButtonListener) {
            CustomActionButtonListeners()
        }
        .onAppear() {
            if(appData.selectedPlayers.count == 1) {
                usingDummyPlayer = true
            }
        }
    }
    
    
    func NextPhaseHandler() {
        if(appData.goToNextPhase == true) {
            appData.goToNextPhase = false
            appData.GoToNextScreen()
        }
    }
    
    
    func NextActionHandler() {
        if(appData.goToNextAction == true) {
            appData.goToNextAction = false
            appData.GoToNextScreen()
        }
    }
    
    
    func NextPlayerHandler() {
        if(appData.goToNextPlayer == true) {
            appData.goToNextPlayer = false
            if endOfRoundAnnounced  &&
                    (appData.currentPlayer + 1  == endOfRoundPlayer || endOfRoundPlayer == 0 && appData.currentPlayer + 1 == appData.selectedPlayers.count) {
                endOfRoundPlayer = nil
                endOfRoundAnnounced = false
                endOfRoundStartedLastCycle = false
                appData.GoToPhaseAction(phaseId: "prepare_round")
            } else {
                if endOfRoundAnnounced && !endOfRoundStartedLastCycle {
                    endOfRoundStartedLastCycle = true
                }
                appData.SetNextPlayer()
                appData.GoToPhaseAction(phaseId: "player_actions", actionId: "pre_turn_check")
            }
        }
    }
    
    
    func CustomActionButtonListeners() {
        if appData.customActionButtonListener == "end_of_round_announced" {
            endOfRoundAnnounced = true
            endOfRoundPlayer = appData.currentPlayer
            appData.goToNextPlayer = true
        }
        if(appData.customActionButtonListener == "round_token_flipped") {
            appData.goToNextPlayer = true
        }
        if(appData.customActionButtonListener == "rest_turn") {
            appData.goToNextPlayer = true
        }
        if(appData.customActionButtonListener == "regular_turn") {
            appData.GoToPhaseAction(actionId: "regular_turn_movement")
        }
        appData.customActionButtonListener = ""
    }
}

#Preview (traits: .modifier(MageKnightPlayerPreviewTrait())){
    PhaseStageView()
}
