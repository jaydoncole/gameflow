//
//  CDMDCreateNewPlayerView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/30/25.
//

import SwiftUI

struct CDMDCreateNewPlayerView: View {
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var newPlayer: PlayerProfile
    @Binding var isPresented: Bool
    
    @State private var selectedPlayer: PlayerProfile?
    @State private var enteredName: String = "Player 1"
    @State private var characterName: String = ""
    
    var body: some View {
            Form {
                Text("Player Name: ")
                TextField("Player Name", text: $enteredName)
                Text("Character Name: ")
                TextField("Character Name", text: $characterName)
                Text("Select Player: ")
                PlayerProfileIcons(selectedPlayer: $selectedPlayer)
                Button(action: {
                    if(selectedPlayer != nil) {
                        selectedPlayer!.playerName = enteredName
                        selectedPlayer!.characterName = characterName
                        newPlayer = selectedPlayer!
                        isPresented = false
                    }
                }, label: {
                    Text("Add Player")
                })
                .buttonStyle(.positiveButtonStyle)
                .disabled(selectedPlayer == nil || enteredName == "")
            }
            .navigationTitle("Create Player")
            .padding()
            .onAppear() {
                enteredName = PlayerHelperMethods.determineDefaultPlayerName(selectedPlayers: appData.selectedPlayers)
            }
    }
}


struct PlayerProfileIcons: View {
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var selectedPlayer: PlayerProfile?
    var body: some View {
        HStack {
            ForEach(appData.currentGame.playerProfiles) { player in
                PlayerIconOrColorView(player: player)
                    .frame(width: player.iconColor == selectedPlayer?.iconColor ? 65 : 50)
                    .onTapGesture {
                        selectedPlayer = player
                    }
                    .disabled(!PlayerHelperMethods.isProfileAvailable(profileId: player.profileId, selectedPlayers: appData.selectedPlayers))
                    .opacity(PlayerHelperMethods.isProfileAvailable(profileId: player.profileId, selectedPlayers: appData.selectedPlayers) ? 1.0 : 0.1)
                if player != appData.currentGame.playerProfiles.last {
                    Spacer()
                }
            }
        }
    }
}

#Preview (traits: .modifier(CDMDGamePreviewTrait())){
    @Previewable @State var newPlayer = PlayerProfile()
    @Previewable @State var isPresented = true
    CDMDCreateNewPlayerView(newPlayer: $newPlayer, isPresented: $isPresented)
}
