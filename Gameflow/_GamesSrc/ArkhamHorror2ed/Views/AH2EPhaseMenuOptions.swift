//
//  AH2EPhaseMenuOptions.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/23/25.
//

import SwiftUI

struct AH2EPhaseMenuOptions: View {
    @Environment(AppData.self) private var appData: AppData
    var body: some View {
        VStack {
            Button(
                action: {
                    appData.helperSheetContent = [
                        BasicActionElement(elementType: .Header2, content: "Victory"),
                        BasicActionElement(elementType: .Header3, content: "Close the Gates"),
                        BasicActionElement(elementType: .Paragraph, content: "1. An Investigator must close the last gate on the board."),
                        BasicActionElement(elementType: .Paragraph, content: "2. The players must have anumber of Gate Trophies equal to or greater than the number of players."),
                        BasicActionElement(elementType: .Header3, content: "Seal the Gates"),
                        BasicActionElement(elementType: .Paragraph, content: "If, at any time, there are six or more elder sign tokens on the board, the players immediately win."),
                        BasicActionElement(elementType: .Header3, content: "Banish the Ancient One"),
                        BasicActionElement(elementType: .Paragraph, content: "If the Ancient One awakens at the players defeat it, they immediately win."),
                        BasicActionElement(elementType: .Header2, content: "Defeat"),
                        BasicActionElement(elementType: .Paragraph, content: "If the Ancient One awakens and defeats all of the investigators in battle, the Ancient One is unleashed.")
                    ]
                    appData.displayHelperSheet = true
                },
                label: {
                    Text("End Game Conditions")
                }
            )
            Button(
                action: {
                    
                },
                label: {
                    Text("Ancient One Awakes Conditions")
                }
            )
        }
    }
}

#Preview (traits: .modifier(AH2EPlayerPreviewTrait())){
    PhaseStageView()
}
