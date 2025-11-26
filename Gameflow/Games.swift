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
        case .ArkhamHorror2ed:
            return AH2EGameData().game
        case .CDMDS1:
            return CDMDGameData().game
        case .MageKnight:
            return MageKnightGameData().game
        case .Unset:
            return UnsetGameData().game
            
        }
    }
    
    var playerProfiles: [PlayerProfile] {
        switch self {
        case .ArkhamHorror2ed:
            return AH2EPlayerProfiles().availablePlayers
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
        case .ArkhamHorror2ed:
            return AH2EGamePhases().gamePhases
        case .CDMDS1:
            return CDMDGamePhases().gamePhases
        case .MageKnight:
            return MageKnightGamePhases().gamePhases
        default:
            return UnsetGamePhases().gamePhases
        }
    }
}


struct createPlayerSetupView: View {
    @State var gameEnum: Games
    var body: some View {
        switch gameEnum {
            case .ArkhamHorror2ed:
                AH2EPlayerSetupView()
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
        case .ArkhamHorror2ed:
            AH2ECreateNewPlayerView(newPlayer: $newPlayer, isPresented: $isPresented)
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
        case .ArkhamHorror2ed:
            AH2EPhaseView()
        case .CDMDS1:
            CDMDPhaseView()
        case .MageKnight:
            MageKnightPhaseView()
        default:
            UnsetPhaseView()
        }
    }
}


struct customPhaseMenuOptions: View {
    @State var gameEnum: Games
    var body: some View {
        switch gameEnum {
            case .ArkhamHorror2ed:
                AH2EPhaseMenuOptions()
            case .CDMDS1:
                CDMDPhasesMenuOptions()
            default:
                UnsetPhasesMenuOptions()
        }
    }
}
