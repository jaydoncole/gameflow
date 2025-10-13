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
            PlayerProfile( profileId: "wolfhawk", characterName: "Wolfhawk", iconColor: .purple, iconImage: "MageKnightWolfhawkPlayer" ),
            PlayerProfile( profileId: "arythea", characterName: "Arythea", iconColor: .red, iconImage: "MageKnightArytheaPlayer" ),
            PlayerProfile( profileId: "norowas", characterName: "Norowa", iconColor: .cyan, iconImage: "MageKnightNorowasPlayer" )
        ]
        
        return appData
    }
    
    func body(content: Content, context: AppData) -> some View {
        content.environment(context)
    }
    
}
