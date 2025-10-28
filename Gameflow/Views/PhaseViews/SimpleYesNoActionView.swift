//
//  SimpleYesNoActionView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/18/25.
//

import SwiftUI

struct SimpleYesNoActionView: View {
    @Binding var variableValue: Bool
    @State var question: String
    @State var actionTitle: String
    
    var body: some View {
        VStack {
            Text(actionTitle).font(.title)
            Toggle(isOn: $variableValue, label: {
                Text(question)
                Text(variableValue ? "Yes" : "No")
            })
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var currentState = true
    SimpleYesNoActionView(variableValue: $currentState, question: "Are you using the dummy player?", actionTitle: "Dummy Player")
}
