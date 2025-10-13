//
//  GameflowApp.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/27/25.
//

import SwiftUI
import SwiftData

@main
struct GameflowApp: App {
    @State private var appData = AppData()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema ([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appData)
        }
        .modelContainer(sharedModelContainer)
    }
}
