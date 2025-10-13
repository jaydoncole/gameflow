//
//  PlayerIconOrColorView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/3/25.
//

import SwiftUI

struct PlayerIconOrColorView: View {
    @State var player: PlayerProfile
    var body: some View {
        if player.iconImage != "" {
            Image(player.iconImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Circle()
                .fill(player.iconColor)
        }
    }
}

#Preview {
    @Previewable @State var testPlayer = PlayerProfile(iconImage: "MageKnightWolfhawkPlayer")
    PlayerIconOrColorView(player: testPlayer)
}
