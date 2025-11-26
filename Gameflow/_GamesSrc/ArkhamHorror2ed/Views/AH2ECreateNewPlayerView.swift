//
//  ArkhamHorror2edCreateNewPlayerView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/15/25.
//

import SwiftUI

struct AH2ECreateNewPlayerView: View {
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var newPlayer: PlayerProfile
    @Binding var isPresented: Bool
    
    @State private var selectedPlayer: PlayerProfile?
    @State private var enteredName: String = "Player 1"
    
    var body: some View {
        NavigationStack {
            Form {
                Text("Player Name: ")
                TextField("Player Name", text: $enteredName)
                Text("Character: ")
                ArkhamHorror2EPlayerProfileList(selectedPlayer: $selectedPlayer)
                Button(action: {
                    if(selectedPlayer != nil) {
                        selectedPlayer!.playerName = enteredName
                        newPlayer = selectedPlayer!
                        isPresented = false
                    }
                    
                }, label: {
                    Text("Add Player")
                })
                .buttonStyle(.positiveButtonStyle)
            }
            .navigationTitle("Create Player")
        }
        .onAppear() {
            enteredName = PlayerHelperMethods
                .determineDefaultPlayerName(selectedPlayers: appData.selectedPlayers)
        }
    }
}

struct ArkhamHorror2EPlayerProfileList: View {
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var selectedPlayer : PlayerProfile?
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(appData.currentGame.playerProfiles) { player in
                    PlayerInformationRow(player: player, iconWidth: 45)
                        .onTapGesture {
                            selectedPlayer = player
                        }
                        .disabled(!PlayerHelperMethods.isProfileAvailable(profileId: player.profileId, selectedPlayers: appData.selectedPlayers))
                        .opacity(PlayerHelperMethods.isProfileAvailable(profileId: player.profileId, selectedPlayers: appData.selectedPlayers) ? 1.0 : 0.1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(player.iconColor == selectedPlayer?.iconColor ? Color.white.opacity(0.2) : Color.white.opacity(0.0))
                }
            }
        }
    }
}

#Preview (traits: .modifier(AH2EGamePreviewTrait())){
    @Previewable @State var newPlayer = PlayerProfile()
    @Previewable @State var isPresented = true
    AH2ECreateNewPlayerView(newPlayer: $newPlayer, isPresented: $isPresented)
}
