//
//  HorizontalPlayerOrderActiveView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/10/25.
//

import SwiftUI

struct HorizontalPlayerOrderActiveView: View {
    @Environment(AppData.self) private var appData: AppData
    
    var body: some View {
        HStack {
            ForEach(appData.selectedPlayers) { player in
                PlayerIconOrColorView(player: player)
                    .frame(width: (player == appData.selectedPlayers[appData.currentPlayer] ? 50 : 30))
            }
            .padding()
        }
        HStack {
            Text(appData.selectedPlayers[appData.currentPlayer].playerName)
            if appData.selectedPlayers[appData.currentPlayer].characterName != "" {
                Text(" : ")
                Text(appData.selectedPlayers[appData.currentPlayer].characterName)
            }
        }
        .foregroundStyle(appData.selectedPlayers[appData.currentPlayer].iconColor).font(.title)
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    HorizontalPlayerOrderActiveView()
}
