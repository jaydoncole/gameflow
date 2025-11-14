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
            if(appData.goToNextPhase == true) {
                appData.goToNextPhase = false
                appData.GoToNextScreen()
            }
        }
        .onChange(of: appData.goToNextAction) {
            if(appData.goToNextAction == true) {
                appData.goToNextAction = false
                appData.GoToNextScreen()
            }
        }
        .onChange(of: appData.goToNextPlayer) {
            if(appData.goToNextPlayer == true) {
                appData.goToNextPlayer = false
                appData.GoToNextScreen()
            }
        }
        .onChange(of: appData.playerEliminated) {
            playerEliminatedHandler()
        }
        
    }
    
    func playerEliminatedHandler() {
        appData.playerEliminated = false
        appData.currentPhase = 0
        appData.currentAction = 0
    }
    
}


#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    CDMDPhaseView()
}
