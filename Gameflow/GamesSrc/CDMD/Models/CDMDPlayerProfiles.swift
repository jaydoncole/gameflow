//
//  CDMDPlayerProfiles.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/30/25.
//

import Foundation
import SwiftUI

struct CDMDPlayerProfiles {
    var availablePlayers: [PlayerProfile] = [
        PlayerProfile(
            profileId: "redPlayer",
            iconColor: .red,
            iconImage: "CDMDRedPlayer"
        ),
        PlayerProfile(
            profileId: "greenPlayer",
            iconColor: .green,
            iconImage: "CDMDGreenPlayer"
        ),
        PlayerProfile(
            profileId: "orangePlayer",
            iconColor: .orange,
            iconImage: "CDMDOrangePlayer"
        ),
        PlayerProfile(
            profileId: "bluePlayer",
            iconColor: .blue,
            iconImage: "CDMDBluePlayer"
        ),
        PlayerProfile (
            profileId: "purplePlayer",
            iconColor: .purple,
            iconImage: "CDMDPurplePlayer"
        )
    ]
}

