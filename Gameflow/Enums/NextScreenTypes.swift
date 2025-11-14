//
//  NextScreenTypes.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/27/25.
//

enum NextScreenTypes : CaseIterable {
    case NextAction
    case NextPhase
    case NextPlayer
    case Hidden // Don't display the "Next <screen type>" button
    case EndGame
}
