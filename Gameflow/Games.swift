//
//  Games.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/28/25.
//

import SwiftUI

enum Games: CaseIterable {
    case ArkhamHorror2ed
    case CDMDS1
    case MageKnight
    case Unset
    
    var gameData: Game {
        switch self {
        case .CDMDS1:
            return CDMDGameData().game
        case .ArkhamHorror2ed:
            return ArkhamHorror2edGameData().game
        case .MageKnight:
            return MageKnightGameData().game
        case .Unset:
            return UnsetGameData().game
            
        }
    }
    
    var playerProfiles: [PlayerProfile] {
        switch self {
        case .CDMDS1:
            return CDMDPlayerProfiles().availablePlayers
        case .MageKnight:
            return MageKnightPlayerProfiles().availablePlayers
        default:
            return UnsetPlayerProfiles().availablePlayers
            
        }
    }
    
    
    var gamePhases: [GamePhase] {
        switch self {
        case .CDMDS1:
            return CDMDGamePhases().gamePhases
        default:
            return UnsetGamePhases().gamePhases
        }
    }
}


struct createPlayerSetupView: View {
    @State var gameEnum: Games
    var body: some View {
        switch gameEnum {
            case .CDMDS1:
                CDMDPlayerSetupView()
            case .MageKnight:
                MageKnightPlayerSetupView()
            default:
                UnsetPlayerSetupView()
        }
    }
}

struct createNewPlayerView: View {
    @State var gameEnum: Games
    @Binding var newPlayer: PlayerProfile
    @Binding var isPresented: Bool
    
    var body: some View {
        switch gameEnum {
        case .CDMDS1:
            CDMDCreateNewPlayerView(newPlayer: $newPlayer, isPresented: $isPresented)
        case .MageKnight:
            MageKnightCreateNewPlayerView(newPlayer: $newPlayer, isPresented: $isPresented)
        default:
            UnsetCreateNewPlayerView()
        }
    }
}


struct gamePhaseView: View {
    @State var gameEnum: Games
    var body: some View {
        switch gameEnum {
        case .CDMDS1:
            CDMDPhaseView()
        default:
            UnsetPhaseView()
        }
    }
}


struct customPhaseMenuOptions: View {
    @State var gameEnum: Games
    var body: some View {
        switch gameEnum {
            case .CDMDS1:
                CDMDPhasesMenuOptions()
            default:
                UnsetPhasesMenuOptions()
        }
    }
}
