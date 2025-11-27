//
//  PhaseStageView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

import SwiftUI

struct PhaseStageView: View {
    @Environment(AppData.self) private var appData
    
    @State var displayHelperSheet: Bool = false
    
    var body: some View {
        VStack {
            // Defined in Games file
            gamePhaseView(gameEnum: appData.currentGame)
            ZStack {
                Button(action: {
                    appData.goToNextAction = true
                }, label: {
                    Text("Next Action")
                })
                .opacity(appData.GetCurrentAction().nextScreenType == .NextAction && appData.showProgressionButtons ? 1.0 : 0.0)
                .disabled(!(appData.GetCurrentAction().nextScreenType == .NextAction) || !appData.showProgressionButtons)
                
                Button(action: {
                    appData.goToNextPhase = true
                }, label: {
                    Text("Next Phase")
                })
                .opacity(appData.GetCurrentAction().nextScreenType == .NextPhase && appData.showProgressionButtons ? 1.0 : 0.0)
                .disabled(!(appData.GetCurrentAction().nextScreenType == .NextPhase) || !appData.showProgressionButtons)
                
                Button(action: {
                    appData.goToNextPlayer = true
                }, label: {
                    Text("Next Player")
                })
                .opacity(appData.GetCurrentAction().nextScreenType == .NextPlayer && appData.showProgressionButtons ? 1.0 : 0.0)
                .disabled(!(appData.GetCurrentAction().nextScreenType == .NextPlayer) || !appData.showProgressionButtons)
                
                Button(action: {
                    appData.showGameOverDialog = true
                }, label: {
                    Text("End Game")
                })
                .opacity(appData.GetCurrentAction().nextScreenType == .EndGame && appData.showProgressionButtons ? 1.0 : 0.0)
                .disabled(!(appData.GetCurrentAction().nextScreenType == .EndGame) || !appData.showProgressionButtons)
            }
        }
        .onAppear() {
            appData.navigationTitle = "Phase: \(appData.GetCurrentPhase().title)"
        }
        .onChange(of: appData.currentPhase) {
            appData.navigationTitle = "Phase: \(appData.GetCurrentPhase().title)"
        }
        .onChange(of: appData.displayHelperSheet) {
            self.displayHelperSheet = appData.displayHelperSheet
        }
        .sheet(isPresented: $displayHelperSheet) {
            // TODO: Figure out how to get Helper Sheets working
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
            Label("Game Options", systemImage: "ellipsis")
        }
    }
}

#Preview (traits: .modifier(AH2EPlayerPreviewTrait())){
//#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    PhaseStageView()
}
