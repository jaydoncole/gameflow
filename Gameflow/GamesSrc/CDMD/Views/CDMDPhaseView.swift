//
//  CDMDPhaseView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

import SwiftUI

struct CDMDPhaseView: View {
    @Environment(AppData.self) private var appData: AppData
    
    @State var currentAction: Int = 0
    
    var body: some View {
        VStack {
            HorizontalPlayerOrderActiveView()
            Text(appData.currentGame.gamePhases[appData.currentPhase].getDescription())
            switch appData.currentGame.gamePhases[appData.currentPhase].phaseId {
                case "action":
                    PhaseTypeSelectableActionView(actionPhaseActions: 3)
                    .onAppear() {
                        appData.showNextPhaseButton = true
                    }
                case "mythos":
                    PhaseTypeConcurrentActionView()
                case "inv-or-fight":
                    PhaseTypeConcurrentActionView()
                case "end-of-turn":
                    PhaseTypeSequentialActionView(currentAction: $currentAction)
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
            currentAction += 1
            if(currentAction + 1 == appData.currentGame.gamePhases.count) {
                appData.showNextPhaseButton = true
                appData.showNextActionButton = false
                currentAction = 0
            }
        }
    }
    
    func playerEliminatedHandler() {
        appData.playerEliminated = false
        appData.currentPhase = 0
        currentAction = 0
    }
}


#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    CDMDPhaseView()
}
