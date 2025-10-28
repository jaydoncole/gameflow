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
    
    var body: some View {
        VStack {
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
        .environment(\.editMode, $editMode)
    }
}

#Preview (traits: .modifier(MageKnightPlayerPreviewTrait())){
    SetPlayerOrderView()
}
