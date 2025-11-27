//
//  SimpleActionView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/7/25.
//

import SwiftUI

struct SimpleActionView: View {
    @Environment(AppData.self) private var appData: AppData
    
    var body: some View {
        if appData.GetCurrentAction().displayInScrollView {
            ScrollView {
                VStack {
                    BasicActionDisplayView()
                }
            }
        } else {
            BasicActionDisplayView()
        }
    }
}

#Preview (traits: .modifier(CDMDPlayerPreviewTrait())){
    SimpleActionView()
}
