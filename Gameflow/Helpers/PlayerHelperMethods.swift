//
//  PlayerHelperMethods.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

class PlayerHelperMethods {
    static func isProfileAvailable(profileId: String, selectedPlayers: [PlayerProfile]) -> Bool {
        var isProfileAvailable = true
        for player in selectedPlayers {
            if profileId == player.profileId {
                isProfileAvailable = false
            }
        }
        return isProfileAvailable
    }
    
    
    static func determineDefaultPlayerName(selectedPlayers: [PlayerProfile]) -> String {
        var playerNameFound = false
        var playerName = ""
        var counter = 1
        while(playerNameFound == false) {
            playerNameFound = true
            playerName = "Player \(counter)"
            for player in selectedPlayers {
                if player.playerName == playerName {
                    playerName = "Player \(counter)"
                    playerNameFound = false
                }
            }
            counter += 1
        }
        return playerName
    }
    
    static func getNextLivePlayer(currentPlayerIndex: Int, selectedPlayers: [PlayerProfile]) -> Int {
        var checkedPlayers: [Int] = []
        var nextLivePlayerFound = false
        var nextLivePlayer = currentPlayerIndex
        
        while !nextLivePlayerFound {
            nextLivePlayer = getNextPlayer(currentPlayerIndex: nextLivePlayer, selectedPlayers: selectedPlayers)
            if checkedPlayers.contains(nextLivePlayer) {
                nextLivePlayer = -1
                nextLivePlayerFound = true
            } else if !selectedPlayers[nextLivePlayer].playerIsDead {
                nextLivePlayerFound = true
            } else {
                checkedPlayers.append(nextLivePlayer)
            }
        }
        return nextLivePlayer
    }
    
    
    static func getNextPlayer(currentPlayerIndex: Int, selectedPlayers: [PlayerProfile]) -> Int {
        var nextPlayer = currentPlayerIndex + 1
        if nextPlayer == selectedPlayers.count {
            nextPlayer = 0
        }
        return nextPlayer
    }
    
    
    static func checkIsLastPlayer(currentPlayerIndex: Int, selectedPlayers: [PlayerProfile]) -> Bool {
        return (currentPlayerIndex + 1 == selectedPlayers.count)
    }
}
