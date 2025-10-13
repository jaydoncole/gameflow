//
//  Game.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/28/25.
//
import Foundation

struct Game: Identifiable, Hashable {
    let id = UUID()
    var gameEnum = Games.Unset
    var name: String = ""
    var edition: String = ""
    var designer: String = ""
    var photo: String = ""
    var minPlayers: Int = 0
    var maxPlayers: Int = 0
    var playerEliminatedMessage: String = ""
}
