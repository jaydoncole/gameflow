//
//  MageKnightGameSetupView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/31/25.
//

import SwiftUI

struct MageKnightGameSetupView: View {
    @Environment(AppData.self) private var appData: AppData
    @Binding var selectedScenario: MageKnightScenario
    @Binding var usingDummyPlayer: Bool
    
    var body: some View {
        switch appData.currentAction {
        case 0:
            MageKnightSelectScenario(selectedScenario: $selectedScenario)
        case 1:
            MageKnightDummyPlayerSelection(usingDummyPlayer: $usingDummyPlayer)
        default:
            Text("No Action is selected")
        }
    }
    
}


struct MageKnightSelectScenario: View {
    @Environment(AppData.self) private var appData: AppData
    
    @State var filteredScenarios: [MageKnightScenario] = []
    @Binding var selectedScenario: MageKnightScenario
    
    let allScenarios = MageKnightScenarios()
    var body: some View {
        VStack {
            Text("Select Scenario").font(.title)
            List($filteredScenarios) { $scenario in
                HStack {
                    if scenario.id == selectedScenario.id {
                        Image(systemName: "arrowshape.right.circle")
                    }
                    Text(scenario.name)
                        .bold(scenario.id == selectedScenario.id ? true : false)
                        .onTapGesture {
                            selectedScenario = scenario
                            appData.showProgressionButtons = true
                        }
                }
            }
            .frame(height: 600)
        }
        .onAppear() {
            appData.showProgressionButtons = false
            filteredScenarios = allScenarios.scenarios.filter({
                for playerNumber in $0.players {
                    if playerNumber == appData.selectedPlayers.count {
                        return true
                    }
                }
                return false
            })
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
                Text("Select the Character the Dummy Player will be using: ")
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
        }
    }
}


#Preview (traits: .modifier(MageKnightPlayerPreviewTrait())){
    PhaseStageView()
}
