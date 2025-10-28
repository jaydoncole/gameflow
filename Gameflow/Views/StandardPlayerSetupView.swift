//
//  StandardPlayerSetupView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/30/25.
//

import SwiftUI

struct StandardPlayerSetupView: View {
    @Environment(AppData.self) private var appData
    
    @State var presentNewPlayerWindow = false
    @State private var newPlayer: PlayerProfile = PlayerProfile()
    
    var body: some View {
        VStack {
            VStack {
                SelectedPlayerList()
                Spacer()
                Button(action: {
                    appData.viewPath.append("Phase View")
                }, label: {
                    Text("Start Game")
                })
                .buttonStyle(.positiveButtonStyle)
                .padding()
                .opacity(appData.selectedPlayers.count < appData.currentGame.gameData.minPlayers ? 0.0 : 1.0)
                HStack {
                    Spacer()
                    AddPlayerButton(
                        presentNewPlayerWindow: $presentNewPlayerWindow,
                        maxPlayers: appData.currentGame.gameData.maxPlayers,
                        newPlayer: $newPlayer
                    )
                }
            }
        }
        .onAppear() {
            appData.navigationTitle = "\(appData.currentGame.gameData.name) Player Setup"
        }
    }
}

struct AddPlayerButton: View {
    @Environment(AppData.self) private var appData: AppData
    @Binding var presentNewPlayerWindow: Bool
    @State var maxPlayers: Int
    @Binding var newPlayer: PlayerProfile
    
    var body: some View {
        Button (action: {
            presentNewPlayerWindow = true
        }) {
            Image(systemName: "plus").frame(width: 30, height: 30)
        }
        .buttonStyle(.positiveButtonStyle)
        .padding()
        .buttonStyle(PlainButtonStyle())
        .disabled(appData.selectedPlayers.count >= maxPlayers)
        .sheet(isPresented: $presentNewPlayerWindow) {
            createNewPlayerView(gameEnum: appData.currentGame, newPlayer: $newPlayer, isPresented: $presentNewPlayerWindow)
            .presentationDetents([.large])
        }
        .onChange(of: newPlayer) {
            appData.selectedPlayers.append(newPlayer)
        }
    }
}


struct SelectedPlayerList: View {
    @Environment(AppData.self) private var appData
    var body: some View {
        List {
            ForEach(appData.selectedPlayers) { player in
                PlayerInformationRow(player: player, iconWidth: 50)
            }
            .onDelete(perform: deleteRow)
        }
    }
    
    func deleteRow(at offsets: IndexSet) {
        appData.selectedPlayers.remove(atOffsets: offsets)
    }
}

#Preview (traits: .modifier(MageKnightGamePreviewTrait())){
    StandardPlayerSetupView()
}
