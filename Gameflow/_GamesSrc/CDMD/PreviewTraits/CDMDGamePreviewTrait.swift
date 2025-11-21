//
//  CDMDGamePreviewTrait.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/3/25.
//

import SwiftUI

struct CDMDGamePreviewTrait: PreviewModifier {
    static func makeSharedContext() async throws -> AppData {
        let appData = AppData()
        
        appData.currentGame = .CDMDS1
        return appData
    }
    
    func body(content: Content, context: AppData) -> some View {
        content.environment(context)
    }
}
