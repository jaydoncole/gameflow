//
//  MageKnightGamePhases.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/12/25.
//

import SwiftUI

struct MageKnightPhaseView: View {
    @Environment(AppData.self) private var appData: AppData
    
    let allScenarios = MageKnightScenarios()
    @State var filteredScenarios: [MageKnightScenario] = []
    @State var selectedScenario: MageKnightScenario = MageKnightScenario()
    @State var usingDummyPlayer: Bool = false
    @State var firstRound: Bool = true
    @State var endOfRoundAnnounced: Bool = false
    
    var body: some View {
        VStack {
            Text(appData.GetCurrentPhase().getDescription())
            switch appData.GetCurrentPhase().phaseId {
                case "game_setup":
                    MageKnightGameSetup(filteredScenarios: $filteredScenarios, selectedScenario: $selectedScenario, usingDummyPlayer: $usingDummyPlayer)
                case "prepare_round":
                    PhaseTypeSequentialActionView()
                case "choose_tactic_cards":
                    SetPlayerOrderView()
                case "player_actions":
                    MageKnightPlayerActions(endOfRoundAnnounced: $endOfRoundAnnounced)
                case "check_for_end_game":
                    Text("Check for Game End!")
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
        .onChange(of: appData.goToNextPlayer) {
            goToNextPlayer()
        }
        .onAppear() {
            filteredScenarios = allScenarios.scenarios.filter({
                for playerNumber in $0.players {
                    if playerNumber == appData.selectedPlayers.count {
                        return true
                    }
                }
                return false
            })
            if(appData.selectedPlayers.count == 1) {
                usingDummyPlayer = true
            }
        }
    }
    
    func goToNextPhase() {
        if appData.goToNextPhase == true {
            appData.currentAction = 0
            // Skip the "Prepare Round" phase the first time
            if firstRound {
                appData.currentPhase = 2
                firstRound = false
            // Player Phase repeats until the End of Round has been Announced
            } else if appData.currentPhase == 3 && !endOfRoundAnnounced {
                goToNextPlayer()
            // The last phase cycles back to Prepare Round phase
            } else if appData.currentPhase + 1 == appData.currentGame.gamePhases.count {
                appData.currentPhase = 1
                appData.currentPlayer = 0
                appData.currentAction = 0
            } else {
                appData.currentPhase += 1
            }
            
            appData.goToNextPhase = false
        }
    }
    
    
    func goToNextAction() {
        if appData.goToNextAction == true {
            if appData.GetCurrentPhase().phaseId == "player_actions" {
                if PhaseHelperMethods.mapIndexToActionRef(phase: appData.GetCurrentPhase(), index: appData.currentAction) == "pre_turn_check" {
                    appData.currentAction = PhaseHelperMethods.mapActionRefToIndex(phase: appData.GetCurrentPhase(), actionRef: "turn_type_selector")
                }
            } else {
                appData.currentAction += 1
            }
            if appData.GetCurrentPhase().phaseId == "prepare_round" {
                appData.ToggleNextPhaseButton()
            }
            appData.goToNextAction = false
        }
    }
    
    
    func goToNextPlayer() {
        if appData.goToNextPlayer {
            let nextPlayer = PlayerHelperMethods.getNextLivePlayer(currentPlayerIndex: appData.currentPlayer, selectedPlayers: appData.selectedPlayers)
            appData.currentPlayer = nextPlayer
            appData.currentAction = 0
            appData.goToNextPlayer = false
            if endOfRoundAnnounced && nextPlayer == 0  {
                appData.goToNextPhase = true
            }
        }
    }
}


struct MageKnightPlayerActions: View {
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var endOfRoundAnnounced: Bool
    
    @State private var gamePhaseActions: [GamePhaseAction] = []
    

    var body: some View {
        VStack {
            HorizontalPlayerOrderActiveView()
            if gamePhaseActions.indices.contains(appData.currentAction) {
                switch(gamePhaseActions[appData.currentAction].getActionRef()) {
                case "pre_turn_check":
                    MageKnightPreTurnCheck(endOfRoundAnnounced: $endOfRoundAnnounced)
                case "turn_type_selector":
                    MageKnightTurnTypeSelector()
                case "rest_turn":
                    PhaseTypeConcurrentActionView()
                default:
                    Text("Invalid Action!")
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear() {
            gamePhaseActions = appData.GetCurrentPhase().getPhaseActions()
        }
    }
}

struct MageKnightTurnTypeSelector: View {
    @Environment(AppData.self) private var appData: AppData
    var body: some View {
        VStack {
            Text("What Turn Type Are You Taking?").font(.title2)
            Button(action: {
                appData.currentAction = PhaseHelperMethods.mapActionRefToIndex(phase: appData.GetCurrentPhase(), actionRef: "rest_turn")
            }, label: {
                Text("Rest")
            })
            Button(action: {
                
            }, label: {
                Text("Regular Turn")
            })
        }
    }
}

struct MageKnightGameSetup: View {
    @Environment(AppData.self) private var appData: AppData
    @Binding var filteredScenarios: [MageKnightScenario]
    @Binding var selectedScenario: MageKnightScenario
    @Binding var usingDummyPlayer: Bool
    
    var body: some View {
        switch appData.currentAction {
        case 0:
            MageKnightSelectScenario(filteredScenarios: $filteredScenarios, selectedScenario: $selectedScenario)
        case 1:
            MageKnightDummyPlayerSelection(usingDummyPlayer: $usingDummyPlayer)
        default:
            Text("No Action is selected")
        }
    }
    
}


struct MageKnightSelectScenario: View {
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var filteredScenarios: [MageKnightScenario]
    @Binding var selectedScenario: MageKnightScenario
    
    var body: some View {
        VStack {
            Text("Select Scenario").font(.title)
            List(filteredScenarios) { scenario in
                HStack {
                    if scenario.id == selectedScenario.id {
                        Image(systemName: "arrowshape.right.circle")
                    }
                    Text(scenario.name)
                        .bold(scenario.id == selectedScenario.id ? true : false)
                    
                        .onTapGesture {
                            selectedScenario = scenario
                            appData.ToggleNextActionButton()
                        }
                }
            }
        }
        .onAppear() {
            appData.HideProgressionButtons()
        }
    }
}


struct MageKnightDummyPlayerSelection: View {
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var usingDummyPlayer: Bool
    @State var availableDummyCharacters: [PlayerProfile] = []
    @State var dummyCharacterProfile: PlayerProfile = PlayerProfile()
    var body: some View {
        VStack {
            SimpleYesNoActionView(variableValue: $usingDummyPlayer, question: "Are you using a dummy player?", actionTitle: "Dummy Player")
            if usingDummyPlayer {
                ForEach(availableDummyCharacters) { character in
                    PlayerInformationRow(player: character, iconWidth: 35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(character.characterName == dummyCharacterProfile.characterName ? Color.white.opacity(0.2) : Color.white.opacity(0.0))
                        .onTapGesture {
                            if appData.selectedPlayers.last?.playerName == "Dummy Player" {
                                appData.selectedPlayers.removeLast()
                            }
                            dummyCharacterProfile = character
                            dummyCharacterProfile.playerName = "Dummy Player"
                            appData.selectedPlayers.append(dummyCharacterProfile)
                        }
                }
            }
        }
        .onAppear() {
            let playerProfiles = MageKnightPlayerProfiles()
            availableDummyCharacters = playerProfiles.availablePlayers.filter({
                for player in appData.selectedPlayers {
                    if player.characterName == $0.characterName {
                        return false
                    }
                }
                return true
            })
            appData.ToggleNextPhaseButton()
        }
    }
}

struct MageKnightPreTurnCheck: View {
    @Environment(AppData.self) private var appData: AppData
    @Binding var endOfRoundAnnounced: Bool
    var body: some View {
        VStack {
            BasicActionDisplayView(groupName: "pre_turn_check")
            if !endOfRoundAnnounced {
                BasicActionDisplayView(groupName: "announce_end_of_round")
            }
        }
        .padding()
        .onAppear() {
            appData.ToggleNextActionButton()
        }
    }
}


#Preview (traits: .modifier(MageKnightPlayerPreviewTrait())){
    PhaseStageView()
}
