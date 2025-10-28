//
//  MageKnightScenario.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/15/25.
//

import Foundation

enum MageKnightScenarioTypes {
    case Competative
    case Cooperative
    case Solo
}

enum MageKnightExpansions {
    case BaseGame
    case TheLostLegion
    case ShadesOfTezla
}

struct MageKnightScenario: Identifiable {
    var id = UUID()
    var scenarioId: String = ""
    var name: String = ""
    var expansion: MageKnightExpansions = .BaseGame
    var players: [Int] = []
    var type: [MageKnightScenarioTypes] = [.Competative]
    var length: String = ""
    var days: Int = 0
    var nights: Int = 0
}
