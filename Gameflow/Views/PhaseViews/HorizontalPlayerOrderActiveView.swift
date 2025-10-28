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
                    .frame(width: (player == appData.GetCurrentPlayer() ? 50 : 30))
            }
            .padding()
        }
        HStack {
            Text(appData.GetCurrentPlayer().playerName)
            if appData.GetCurrentPlayer().characterName != "" {
                Text(" : ")
                Text(appData.GetCurrentPlayer().characterName)
            }
        }
        .foregroundStyle(appData.GetCurrentPlayer().iconColor).font(.title3)
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    HorizontalPlayerOrderActiveView()
}
