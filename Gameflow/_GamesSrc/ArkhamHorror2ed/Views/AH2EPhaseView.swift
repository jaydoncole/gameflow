//
//  AH2EPhaseView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/15/25.
//

import SwiftUI

struct AH2EPhaseView: View {
    @Environment(AppData.self) private var appData: AppData
    @State var firstTurn:Bool = true
    // If we have a monster battle, we want to go back to the phase we were at afterwards
    @State var currentPhase: Int = -1
    @State var playersLostInTimeAndSpacePhaseOne: [String] = []
    @State var playersLostInTimeAndSpacePhaseTwo: [String] = []

    var body: some View {
        VStack {
            if ShowPlayerOrder() {
                HorizontalPlayerOrderActiveView()
            }
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
                PhaseTypeAccordianActionView()
            case "arkham_encounters_phase":
                PhaseTypeAccordianActionView()
            case "other_world_encounters_phase":
                SimpleActionView()
            case "turn_end_phase":
                SimpleActionView()
            case "monster_battle_phase":
                PhaseTypeSequentialActionView()
            case "lost_in_time_and_space_phase_one":
                SimpleActionView()
            case "lost_in_time_and_space_phase_two":
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
                // The first time through the mythos phase we got to the upkeep phase, after that we go to the Turn End PHase
                if appData.GetCurrentPhase().phaseId == "mythos_phase" {
                    if firstTurn {
                        firstTurn = false
                    } else {
                        appData.nextScreenOverride = "turn_end_phase"
                    }
                }
                if appData.GetCurrentPhase().phaseId == "turn_end_phase" {
                    RotateFirstPlayer()
                }
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
            if appData.goToNextPlayer == true {
                print("Current Player: \(appData.GetCurrentPlayer().profileId)")
                appData.goToNextPlayer = false
                if (appData.GetCurrentPhase().phaseId == "movement_phase" || appData.GetCurrentPhase().phaseId == "lost_in_time_and_space_phase_one" || appData.GetCurrentPhase().phaseId == "lost_in_time_and_space_phase_two") && IsLastPlayer() {
                    appData.currentPlayer = 0
                    appData.GoToPhaseAction(phaseId: "arkham_encounters_phase")
                }
                else if appData.GetCurrentPhase().phaseId == "arkham_encounters_phase" && IsLastPlayer() {
                    appData.currentPlayer = 0
                    appData.GoToPhaseAction(phaseId: "other_world_encounters_phase")
                }
                else if appData.GetCurrentPhase().phaseId == "other_world_encounters_phase" && IsLastPlayer() {
                    appData.currentPlayer = 0
                    appData.GoToPhaseAction(phaseId: "mythos_phase")
                }
                else if appData.GetCurrentPhase().phaseId == "monster_battle_phase" {
                    ReturnToFlow()
                } else if appData.GetCurrentPhase().phaseId == "movement_phase" {
                    MovementHandler(profileId: GetNextProfileId())
                    if appData.GetCurrentPhase().phaseId == "movement_phase" {
                        appData.GoToNextScreen()
                    }
                } else {
                    appData.GoToNextScreen()
                }
            }
        }
        .onChange(of: appData.currentPhase) {
            if appData.GetCurrentPhase().phaseId == "movement_phase" {
                MovementHandler(profileId: appData.GetCurrentPlayer().profileId)
            }
            if appData.GetCurrentPhase().phaseId == "lost_in_time_and_space_phase_one" || appData.GetCurrentPhase().phaseId == "lost_in_time_and_space_phase_two" {
                print("In Lost In Time And Space Phase One")
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
        } else if appData.customActionButtonListener == "battle_monster" {
            if currentPhase == -1 {
                currentPhase = appData.currentPhase
            }
            appData.GoToPhaseAction(phaseId: "monster_battle_phase")
        } else if appData.customActionButtonListener == "lost_in_time_and_space" {
            print("Lost in time and space")
            playersLostInTimeAndSpacePhaseOne.append(appData.GetCurrentPlayer().profileId)
            ReturnToFlow()
        }
        appData.customActionButtonListener = ""
    }
    
    func RotateFirstPlayer() {
        appData.selectedPlayers.append(appData.selectedPlayers.removeFirst())
        appData.currentPlayer = PlayerHelperMethods.getNextLivePlayer(currentPlayerIndex: appData.selectedPlayers.count - 1, selectedPlayers: appData.selectedPlayers)
    }
    
    func IsLastPlayer() -> Bool {
        return appData.currentPlayer == appData.selectedPlayers.count - 1
    }
    
    func ShowPlayerOrder() -> Bool {
        return appData.GetCurrentPhase().phaseId == "movement_phase"
            || appData.GetCurrentPhase().phaseId == "arkham_encounters_phase"
            || appData.GetCurrentPhase().phaseId == "other_world_encounters_phase"
    }
    
    func ReturnToFlow() {
        appData.currentPhase = self.currentPhase
        appData.currentAction = 0
        self.currentPhase = -1
        appData.GoToNextScreen()
    }
    
    func MovementHandler(profileId: String) {
        if CheckPlayerContainedIn(checkArray: playersLostInTimeAndSpacePhaseOne, character: profileId) {
            playersLostInTimeAndSpacePhaseOne.removeAll(where: { value in
                value == appData.GetCurrentPlayer().profileId
            })
            playersLostInTimeAndSpacePhaseTwo.append(appData.GetCurrentPlayer().profileId)
            print("Going To: Lost In Time and Space Phase One")
            appData.GoToPhaseAction(phaseId: "lost_in_time_and_space_phase_one")
        } else if CheckPlayerContainedIn(checkArray: playersLostInTimeAndSpacePhaseTwo, character: profileId) {
            playersLostInTimeAndSpacePhaseTwo.removeAll(where: { value in
                value == appData.GetCurrentPlayer().profileId
            })
            print("Going To: Lost In Time and Space Phase Two")
            appData.GoToPhaseAction(phaseId: "lost_in_time_and_space_phase_two")
        }
    }
    
    
    
    func CheckPlayerContainedIn(checkArray: [String], character: String) -> Bool {
        let arrayContains = checkArray.contains(where: { value in
            print("Current Player: \(character) Player In Time And Space: \(value)")
            return value == character
        })
        return arrayContains
    }
    
    func GetNextProfileId() -> String {
        let nextLivePlayerIndex = PlayerHelperMethods.getNextLivePlayer(currentPlayerIndex: appData.currentPlayer, selectedPlayers: appData.selectedPlayers)
        return appData.selectedPlayers[nextLivePlayerIndex].profileId
    }
}

#Preview (traits: .modifier(AH2EPlayerPreviewTrait())){
    PhaseStageView()
}
