//
//  PhaseTypeSequentialActionView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/11/25.
//

import SwiftUI

struct PhaseTypeSequentialActionView: View {
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var currentAction: Int
    var body: some View {
        VStack() {
            Text(appData.currentGame.gamePhases[appData.currentPhase].getPhaseAction(index: currentAction).getName())
                .font(.headline)
            Text(appData.currentGame.gamePhases[appData.currentPhase].getPhaseAction(index: currentAction).getHelper())
        }.onAppear() {
            appData.showNextPhaseButton = false
            appData.showNextActionButton = true
        }
        .padding()
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    @Previewable @State var currentAction = 0

    PhaseTypeSequentialActionView(currentAction: $currentAction)
}
