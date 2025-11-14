//
//  MageKnightPlayerActionsView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/1/25.
//

import SwiftUI

struct MageKnightPlayerActionsView: View {
    
    @Environment(AppData.self) private var appData: AppData
    
    @Binding var endOfRoundAnnounced: Bool
    
    @State private var gamePhaseActions: [GamePhaseAction] = []
    
    
    var body: some View {
        VStack {
            HorizontalPlayerOrderActiveView()
            if gamePhaseActions.indices.contains(appData.currentAction) {
                switch(gamePhaseActions[appData.currentAction].getActionRef()) {
                case "pre_turn_check":
                    MageKnightPreTurnCheck(endOfRoundAnnounced: $endOfRoundAnnounced)
                case "turn_type_selector":
                    SimpleActionView()
                case "rest_turn":
                    PhaseTypeConcurrentActionView()
                case "regular_turn_movement":
                    SimpleActionView()
                case "mandetory_actions":
                    SimpleActionView()
                case "voluntary_actions":
                    SimpleActionView()
                default:
                    Text("Invalid Action!")
                }
            } else {
                Text("Loading...")
            }
        }
        .onAppear() {
            gamePhaseActions = appData.GetCurrentPhase().getPhaseActions()
        }
    }
}

struct MageKnightPreTurnCheck: View {
    @Environment(AppData.self) private var appData: AppData
    @Binding var endOfRoundAnnounced: Bool
    var body: some View {
        VStack {
            BasicActionDisplayView(groupName: "pre_turn_check")
            if !endOfRoundAnnounced {
                BasicActionDisplayView(groupName: "announce_end_of_round")
            }
        }
        .padding()
    }
}


#Preview (traits: .modifier(MageKnightPlayerPreviewTrait())){
    PhaseStageView()
}
