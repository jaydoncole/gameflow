//
//  AH2EGamePreviewTrait.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/15/25.
//

import SwiftUI

struct AH2EGamePreviewTrait: PreviewModifier {
    static func makeSharedContext() async throws -> AppData {
        let appData = AppData()
        
        appData.currentGame = .ArkhamHorror2ed
        return appData
    }
    
    func body(content: Content, context: AppData) -> some View {
        content.environment(context)
    }
}
