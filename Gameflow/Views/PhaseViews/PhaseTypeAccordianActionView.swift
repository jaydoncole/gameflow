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
            ForEach(appData.GetCurrentPhase().getPhaseActions()) { action in
                DisclosureGroup(action.getName()) {
                    BasicActionDisplayView(actionRef: action.getActionRef())
                }
            }
        }
        .onAppear() {
            for action in appData.GetCurrentPhase().getPhaseActions() {
                toggles[action.getActionRef()] = false
            }
        }
    }
}

#Preview (traits: .modifier(AH2EPlayerPreviewTrait())){
    PhaseStageView()
}
