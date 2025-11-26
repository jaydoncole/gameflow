//
//  AH2EPlayerPreviewTrait.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/15/25.
//

import SwiftUI

struct AH2EPlayerPreviewTrait: PreviewModifier {
    static func makeSharedContext() async throws -> AppData {
        let appData = AppData()
        
        appData.currentGame = .ArkhamHorror2ed
        appData.selectedPlayers = [
            PlayerProfile( profileId: "carolynfern", characterName: "Carolyn Fern", playerName: "Player 4", iconColor: Color(red: 53, green: 113, blue: 141), iconImage: "AH2ECarolynFern"),
            PlayerProfile( profileId: "mandythompson", characterName: "Mandy Thompson", playerName: "Player 2", iconColor: Color(red: 231, green: 189, blue: 126), iconImage: "AH2EMandyThompson"),
            PlayerProfile( profileId: "normanwithers", characterName: "Norman Withers", playerName: "Player 3", iconColor: Color(red: 83, green: 85, blue: 116), iconImage: "AH2ENormanWithers"),
            PlayerProfile( profileId: "patricehathaway", characterName: "Patrice Hathaway", playerName: "Player 1", iconColor: Color(red: 167, green: 164, blue: 118), iconImage: "AH2EPatriceHathaway" )
        ]
        appData.currentPhase = 0
        return appData
    }
    
    func body(content: Content, context: AppData) -> some View {
        content.environment(context)
    }
}
