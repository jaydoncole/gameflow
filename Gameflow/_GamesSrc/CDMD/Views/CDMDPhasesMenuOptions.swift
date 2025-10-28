//
//  CDMDPhasesMenuOptions.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/11/25.
//

import SwiftUI

struct CDMDPhasesMenuOptions: View {
    @Environment(AppData.self) private var appData: AppData
    
    @State private var isPresentingDeathConfirmation = false
    var body: some View {
        Button(
            role: .destructive,
            action: {
                print("Player Dead!")
                appData.showPlayerEliminatedMessage = true
            },
            label: {
                Text("Player Dead/Insane")
            }
        )
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    CDMDPhasesMenuOptions()
}
