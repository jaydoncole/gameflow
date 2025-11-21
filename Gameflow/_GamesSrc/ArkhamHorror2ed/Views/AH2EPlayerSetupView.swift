//
//  AH2EPlayerSetupView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/15/25.
//

import SwiftUI

struct AH2EPlayerSetupView: View {
    var body: some View {
        StandardPlayerSetupView()
    }
}

#Preview (traits: .modifier(AH2EGamePreviewTrait())) {
    AH2EPlayerSetupView()
        .environment(AppData())
}
