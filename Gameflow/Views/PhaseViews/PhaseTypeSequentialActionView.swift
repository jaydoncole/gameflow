//
//  PhaseTypeSequentialActionView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/11/25.
//

import SwiftUI

struct PhaseTypeSequentialActionView: View {
    @Environment(AppData.self) private var appData: AppData
    @State private var currentActionElements: [BasicActionElement] = []
    
    var body: some View {
        VStack() {
            Text(appData.GetCurrentAction().getName())
                .font(.headline)
            BasicActionDisplayView()
        }.onAppear() {
            determinePhaseActionButtons()
        }
        .onChange(of: appData.goToNextAction) {
            determinePhaseActionButtons()
        }
        .padding()
    }
    
    
    func determinePhaseActionButtons() {
        appData.DetermineNextPhaseActionButton()
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    PhaseTypeSequentialActionView()
}
