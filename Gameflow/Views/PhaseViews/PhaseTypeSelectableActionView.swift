//
//  PhaseTypeActionView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/10/25.
//

import SwiftUI

struct PhaseTypeSelectableActionView: View {
    @Environment(AppData.self) private var appData: AppData
    
    @State var actionPhaseActions: Int
    @State var actionsTaken: [GamePhaseAction] = []

    var body: some View {
        VStack() {
            ForEach(appData.currentGame.gamePhases[appData.currentPhase].getPhaseActions()) { action in
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: action.getActionIcon()).foregroundStyle(appData.selectedPlayers[appData.currentPlayer].iconColor)
                            Text(action.getName()).font(.headline)
                            Spacer()
                            Button(action: {
                                actionsTaken.append(action)
                            }, label: {
                                Image(systemName: "square.and.arrow.down.badge.checkmark")
                            }).foregroundStyle(appData.selectedPlayers[appData.currentPlayer].iconColor)
                        }
                        Text(action.getHelper()).font(.caption)
                    }
                }.padding()
            }.frame(width: 350)
            Spacer()
            Text("Actions Taken")
            HStack() {
                ForEach(0..<actionPhaseActions, id: \.self) {index in
                    Button(action: {
                        if(actionsTaken.indices.contains(index)) {
                            actionsTaken.remove(at: index)
                        }
                    }, label: {
                        Image(systemName: actionsTaken.indices.contains(index) ? actionsTaken[index].getActionIcon() : "square")
                            .foregroundStyle(appData.selectedPlayers[appData.currentPlayer].iconColor)
                    })
                }
            }
        }
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    PhaseTypeSelectableActionView(actionPhaseActions: 3)
}
