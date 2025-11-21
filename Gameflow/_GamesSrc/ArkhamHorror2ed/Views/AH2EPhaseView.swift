//
//  AH2EPhaseView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/15/25.
//

import SwiftUI

struct AH2EPhaseView: View {
    @Environment(AppData.self) private var appData: AppData
    
    var body: some View {
        VStack {
            Text(appData.GetCurrentPhase().getDescription())
            switch appData.GetCurrentPhase().phaseId {
            case "game_setup":
                SetPlayerOrderView(helperText: "Choose First Player and set the player order ")
            case "mythos_phase":
                switch appData.GetCurrentPhase().getPhaseActions()[appData.currentAction].getActionRef() {
                    case "open_gate_elder_sign", "open_gate_gate_exists", "open_gate_no_gate":
                        SimpleActionView()
                    default:
                        PhaseTypeSequentialActionView()
                }
            case "upkeep_phase":
                SimpleActionView()
            case "movement_phase":
                SimpleActionView()
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
        .onChange(of: appData.customActionButtonListener) {
            CustomActionButtonListeners()
        }
        .onAppear() {
            appData.valueReplacements = [
                ValueReplacement(needle: "[[monster_draw_number]]", value: appData.selectedPlayers.count > 4 ? "2" : "1"),
                ValueReplacement(needle: "[[max_monsters]]", value: "\(appData.selectedPlayers.count + 3)"),
                ValueReplacement(needle: "[[max_outskirts]]", value: "\(8 - appData.selectedPlayers.count)")
            ]
        }
    }
    
    func CustomActionButtonListeners() {
        if appData.customActionButtonListener == "location_has_elder_sign" {
            appData.GoToPhaseAction(actionId: "open_gate_elder_sign")
        } else if appData.customActionButtonListener == "location_has_open_gate" {
            appData.GoToPhaseAction(actionId: "open_gate_gate_exists")
        } else if appData.customActionButtonListener == "location_has_no_gate" {
            appData.GoToPhaseAction(actionId: "open_gate_no_gate")
        }
        appData.customActionButtonListener = ""
    }
}

#Preview (traits: .modifier(AH2EPlayerPreviewTrait())){
    PhaseStageView()
}
