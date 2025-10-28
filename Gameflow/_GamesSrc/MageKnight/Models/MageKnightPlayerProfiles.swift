//
//  MageKnightPlayerProfiles.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/3/25.
//

import Foundation
import SwiftUI

struct MageKnightPlayerProfiles {
    var availablePlayers: [PlayerProfile] = [
        PlayerProfile(
            profileId: "goldyx",
            characterName: "Goldyx",
            iconColor: .green,
            iconImage: "MageKnightGoldyxPlayer"
        ),
        PlayerProfile(
            profileId: "wolfhawk",
            characterName: "Wolfhawk",
            iconColor: .purple,
            iconImage: "MageKnightWolfhawkPlayer"
        ),
        PlayerProfile(
            profileId: "arythea",
            characterName: "Arythea",
            iconColor: .red,
            iconImage: "MageKnightArytheaPlayer"
        ),
        PlayerProfile(
            profileId: "norowas",
            characterName: "Norowa",
            iconColor: .cyan,
            iconImage: "MageKnightNorowasPlayer"
        ),
        PlayerProfile (
            profileId: "krang",
            characterName: "Krang",
            iconColor: .brown,
            iconImage: "MageKnightKrangPlayer"
        ),
        PlayerProfile (
            profileId: "breavalar",
            characterName: "Breavalar",
            iconColor: .mint,
            iconImage: "MageKnightBraevalarPlayer"
        ),
        PlayerProfile (
            profileId: "tovak",
            characterName: "Tovak",
            iconColor: .gray,
            iconImage: "MageKnightTovakPlayer"
        ),
    ]
}
