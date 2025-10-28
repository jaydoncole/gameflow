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
            ForEach(appData.GetCurrentPhase().getPhaseActions()) { action in
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: action.getActionIcon()).foregroundStyle(appData.GetCurrentPlayer().iconColor)
                            Text(action.getName()).font(.headline)
                            Spacer()
                            Button(action: {
                                actionsTaken.append(action)
                            }, label: {
                                Image(systemName: "square.and.arrow.down.badge.checkmark")
                            }).foregroundStyle(appData.GetCurrentPlayer().iconColor)
                        }
                        BasicActionDisplayView()
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
                            .foregroundStyle(appData.GetCurrentPlayer().iconColor)
                    })
                }
            }
        }
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    PhaseTypeSelectableActionView(actionPhaseActions: 3)
}
