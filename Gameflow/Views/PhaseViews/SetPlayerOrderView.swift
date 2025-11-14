//
//  SetPlayerOrderView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/18/25.
//

import SwiftUI

struct SetPlayerOrderView: View {
    @Environment(AppData.self) private var appData: AppData
    @State var editMode = EditMode.active
    // OPtional text if there's additional information for the Phase where player order is selected
    @State var helperText: String = ""
    
    var body: some View {
        VStack {
            if helperText != "" {
                Text(helperText)
            }
            Text("Set Player Order")
            List {
                ForEach(appData.selectedPlayers) { player in
                    PlayerInformationRow(player: player, iconWidth: 35)
                }
                .onMove { from, to in
                    appData.selectedPlayers.move(fromOffsets: from, toOffset: to)
                }
            }
        }
        .onAppear() {
            appData.currentPlayer = 0
        }
        .environment(\.editMode, $editMode)
    }
}

#Preview (traits: .modifier(MageKnightPlayerPreviewTrait())){
    SetPlayerOrderView()
}
