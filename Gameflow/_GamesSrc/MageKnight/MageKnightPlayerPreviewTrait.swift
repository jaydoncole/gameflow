//
//  MageKnightPlayerPreviewTrait.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

import SwiftUI

struct MageKnightPlayerPreviewTrait: PreviewModifier {
    static func makeSharedContext() async throws -> AppData {
        let appData = AppData()
        
        appData.currentGame = .MageKnight
        appData.selectedPlayers = [
            PlayerProfile( profileId: "wolfhawk", characterName: "Wolfhawk", playerName: "Player 1", iconColor: .purple, iconImage: "MageKnightWolfhawkPlayer" ),
            PlayerProfile( profileId: "arythea", characterName: "Arythea", playerName: "Player 2", iconColor: .red, iconImage: "MageKnightArytheaPlayer" ),
            PlayerProfile( profileId: "norowas", characterName: "Norowa", playerName: "Player 3", iconColor: .cyan, iconImage: "MageKnightNorowasPlayer" )
        ]
        
        return appData
    }
    
    func body(content: Content, context: AppData) -> some View {
        content.environment(context)
    }
    
}
