//
//  PhaseTypeAccordianActionView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/22/25.
//

import SwiftUI

struct PhaseTypeAccordianActionView: View {
    @Environment(AppData.self) private var appData: AppData
    
    @State private var expandedIndex: Int? = nil
    @State private var rowIndex = 0
    @State private var toggles: [String: Bool] = [:]
    
    var body: some View {
        VStack() {
            ForEach(appData.GetCurrentPhase().phaseActions) { action in
                DisclosureGroup(action.name) {
                    BasicActionDisplayView(actionRef: action.actionRef)
                }
            }
        }
        .onAppear() {
            for action in appData.GetCurrentPhase().phaseActions {
                toggles[action.actionRef] = false
            }
        }
    }
}

#Preview (traits: .modifier(AH2EPlayerPreviewTrait())){
    PhaseStageView()
}
