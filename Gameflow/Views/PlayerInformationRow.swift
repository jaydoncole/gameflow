//
//  PlayerInformationRow.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/18/25.
//

import SwiftUI

struct PlayerInformationRow: View {
    var player: PlayerProfile
    var iconWidth: CGFloat
    var body: some View {
        HStack {
            PlayerIconOrColorView(player: player)
                .frame(width: iconWidth)
            Text(player.playerName)
            if player.characterName != "" {
                Text(" : ")
                Text(player.characterName)
            }
        }
    }
}

#Preview {
    PlayerInformationRow(player: PlayerProfile(profileId: "arythea", characterName: "Arythea", iconColor: .red, iconImage: "MageKnightArytheaPlayer"), iconWidth: 50)
}
