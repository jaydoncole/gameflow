//
//  BasicActionElement.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/25/25.
//
import Foundation

struct BasicActionElement: Identifiable {
    let id = UUID()
    var elementType: BasicActionTypes = .Paragraph
    var content: String = ""
    // If there's a custom button (branching actions) this will hold the value that we're listening for
    var customButtonListener: String = ""
    // We may want to do custom stuff for a field/group of fields (such as hide them in certain conditions"
    var groupName: String = "_"
}
