//
//  RuleReference.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/22/25.
//
import Foundation

struct RuleReference: Identifiable {
    let id = UUID()
    var referenceId: String = ""
    var elements: [BasicActionElement] = []
}
