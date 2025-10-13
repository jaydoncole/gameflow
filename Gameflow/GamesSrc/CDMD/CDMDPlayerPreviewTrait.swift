//
//  CDMDPlayerPreviewTrait.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

import SwiftUI

struct CDMDPlayerPreviewTrait: PreviewModifier {
    static func makeSharedContext() async throws -> AppData {
        let appData = AppData()
        
        appData.currentGame = .CDMDS1
        appData.selectedPlayers = [
            PlayerProfile(characterName: "Rasputin", playerName: "Player 1", iconColor: .red, iconImage: "CDMDRedPlayer"),
            PlayerProfile(characterName: "Borden", playerName: "Player 2", iconColor: .purple, iconImage: "CDMDPurplePlayer"),
            PlayerProfile(characterName: "The Kid", playerName: "Player 3", iconColor: .orange, iconImage: "CDMDOrangePlayer")
        ]
        appData.currentPhase = 0
        return appData
    }
    
    func body(content: Content, context: AppData) -> some View {
        content.environment(context)
    }
}
