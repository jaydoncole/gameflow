//
//  PhaseStageView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

import SwiftUI

struct PhaseStageView: View {
    @Environment(AppData.self) private var appData
    var body: some View {
        NavigationView {
            VStack {
                // Defined in Games file
                gamePhaseView(gameEnum: appData.currentGame)
                ZStack {
                    Button(action: {
                        appData.goToNextAction = true
                    }, label: {
                        Text("Next Action")
                    })
                    .opacity(appData.showNextActionButton ? 1.0 : 0.0)
                    .disabled(!appData.showNextActionButton)
                    
                    Button(action: {
                        appData.goToNextPhase = true
                    }, label: {
                        Text("Next Phase")
                    })
                    .opacity(appData.showNextPhaseButton ? 1.0 : 0.0)
                    .disabled(!appData.showNextPhaseButton)
                }
                .navigationTitle(Text("Phase: \(appData.currentGame.gamePhases[appData.currentPhase].getTitle())"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        GameOptionsMenu()
                    }
                }
            }
        }
    }
}

struct GameOptionsMenu: View {
    @Environment(AppData.self) private var appData
    var body: some View {
        Menu {
            customPhaseMenuOptions(gameEnum: appData.currentGame)
            // Defined in Games
            Button(
                role: .destructive,
                action: {
                    appData.showGameOverDialog = true
                },
                label: {
                    Text("End Game")
                }
            )
        } label: {
            Label("Game Options", systemImage: "arrow.up.arrow.down")
        }
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    PhaseStageView()
}
