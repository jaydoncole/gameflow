//
//  PhaseTypeConcurrentActionView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/10/25.
//

import SwiftUI

struct PhaseTypeConcurrentActionView: View {
    @Environment(AppData.self) private var appData: AppData
    
   // @State var currentGamePhase: GamePhase
    var body: some View {
        VStack {
            ForEach(appData.GetCurrentPhase().phaseActions) { action in
                VStack(alignment: .leading) {
                    Text(action.name).font(.headline)
                    BasicActionDisplayView()
                }.padding()
            }.padding()
        }
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    PhaseTypeConcurrentActionView()
}
