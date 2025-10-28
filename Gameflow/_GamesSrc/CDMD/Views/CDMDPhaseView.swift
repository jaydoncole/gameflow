//
//  CDMDPhaseView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

import SwiftUI

struct CDMDPhaseView: View {
    @Environment(AppData.self) private var appData: AppData
    
    var body: some View {
        VStack {
            HorizontalPlayerOrderActiveView()
            Text(appData.GetCurrentPhase().getDescription())
            switch appData.GetCurrentPhase().phaseId {
                case "action":
                    PhaseTypeSelectableActionView(actionPhaseActions: 3)
                    .onAppear() {
                        appData.ToggleNextPhaseButton()
                    }
                case "mythos":
                    PhaseTypeConcurrentActionView()
                case "inv-or-fight":
                    PhaseTypeConcurrentActionView()
                case "end-of-turn":
                    PhaseTypeSequentialActionView()
                default:
                    Text("No Phase Selected!")
            }
            Spacer()
        }
        .padding()
        .onChange(of: appData.goToNextPhase) {
            goToNextPhase()
        }
        .onChange(of: appData.goToNextAction) {
            goToNextAction()
        }
        .onChange(of: appData.playerEliminated) {
            playerEliminatedHandler()
        }
    }
    
    
    func goToNextPhase() {
        if(appData.goToNextPhase == true) {
            appData.goToNextPhase = false
            appData.currentAction = 0
            if appData.currentPhase + 1 == appData.currentGame.gamePhases.count {
                appData.currentPhase = 0
                let nextPlayer = PlayerHelperMethods.getNextLivePlayer(currentPlayerIndex: appData.currentPlayer, selectedPlayers: appData.selectedPlayers)
                if nextPlayer == -1 {
                    appData.showAllPlayersDead = true
                } else {
                    appData.currentPlayer = nextPlayer
                }
            } else {
                appData.currentPhase += 1
            }
        }
    }
    
    func goToNextAction() {
        if(appData.goToNextAction == true) {
            appData.goToNextAction = false
            appData.currentAction += 1
        }
    }
    
    func playerEliminatedHandler() {
        appData.playerEliminated = false
        appData.currentPhase = 0
        appData.currentAction = 0
        appData.ToggleNextPhaseButton()
    }
}


#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    CDMDPhaseView()
}
