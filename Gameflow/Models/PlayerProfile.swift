//
//  PlayerProfile.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/30/25.
//

import Foundation
import SwiftUI

struct PlayerProfile: Identifiable, Hashable {
    let id = UUID()
    var profileId: String = ""
    var characterName: String = ""
    var playerName: String = ""
    var iconColor: Color = .white
    var iconImage: String = ""
    var playerIsDead: Bool = false
}
