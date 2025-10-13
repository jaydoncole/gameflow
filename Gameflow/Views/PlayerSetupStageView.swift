//
//  PlayerSetupStageView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/30/25.
//

import SwiftUI

struct PlayerSetupStageView: View {
    @Environment(AppData.self) private var appData
    var body: some View {
        // Defined in Games enum file
        createPlayerSetupView(gameEnum: appData.currentGame)
    }
}

#Preview {
    PlayerSetupStageView()
        .environment(AppData())
}
