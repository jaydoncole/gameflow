//
//  ValueReplacement.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/20/25.
//
// Some games may have slightly modified rules depending on certain conditions
// (ie. the Monster Limit based on number of players in Arkham Horror)
// this holds a "variables" to be replaced within text strings of BasicActionElements

struct ValueReplacement {
    var needle: String = ""
    var value: String = ""
}
