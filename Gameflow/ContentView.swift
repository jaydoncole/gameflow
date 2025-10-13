//
//  ContentView.swift
//  Gameflow
//
//  Created by Jaydon Cole on 9/27/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppData.self) private var appData
    
    @State private var filteredGames: [Game] = []
    @State private var gameList: [Game] = []
    
    var body: some View {
        @Bindable var appData = appData
        NavigationStack(path: $appData.viewPath) {
            GameListView(filteredGames: $filteredGames, gameList: $gameList)
            .navigationTitle(Text("Games"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(value: "Settings View", label: {
                        Image(systemName: "gear")
                    })
                }
            }
            .navigationDestination(for: Game.self, destination: { game in
                PlayerSetupStageView()
            })
            .navigationDestination(for:String.self, destination: { viewId in
                if viewId == "Settings" {
                    // Settings View
                } else if viewId == "Phase View" {
                    PhaseStageView()
                }
            })
        }
        .alert("Game Over", isPresented: $appData.showGameOverDialog, actions: {
            Button(role: .destructive) {
                appData.viewPath = NavigationPath()
                appData.resetGame = true
            } label: {
                Text("Okay")
            }
        }, message: {
            Text("The game has ended and will be reset")
        })
        .confirmationDialog(
            "Player Elimination",
            isPresented: $appData.showPlayerEliminatedMessage,
        ) {
            Button("Confirm", role: .destructive) {
                appData.selectedPlayers[appData.currentPlayer].playerIsDead = true
                let nextLivePlayer = PlayerHelperMethods.getNextLivePlayer(currentPlayerIndex: appData.currentPlayer, selectedPlayers: appData.selectedPlayers)
                if(nextLivePlayer == -1) {
                    appData.showGameOverDialog = true
                } else {
                    appData.playerEliminated = true
                    appData.currentPlayer = nextLivePlayer
                }
            }
        } message: {
            Text(appData.currentGame.gameData.playerEliminatedMessage)
        }
        .onAppear() {
            gameList = generateGameList()
            filteredGames = gameList
        }
    }
    
    
    func generateGameList() -> [Game] {
        var gameList: [Game] = []
        for gameEnum in Games.allCases {
            if gameEnum != .Unset {
                gameList.append(gameEnum.gameData)
            }
        }
        return gameList
    }
}


struct GameItemView: View {
    let game: Game
    var body: some View {
        HStack {
            Image(game.photo)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .aspectRatio(contentMode: .fit)
                .frame(width: 90)
            VStack(alignment: .leading) {
                Text(game.name).fontWeight(.heavy)
                Text(game.edition)
                Text(game.designer)
            }
        }
    }
}


struct GameListView: View {
    @Environment(AppData.self) private var appData
    
    @Binding var filteredGames: [Game]
    @Binding var gameList: [Game]
    
    @State private var gameSearch: String = ""
    
    var body: some View {
        List(filteredGames) { game in
            NavigationLink(value: game, label: {
                GameItemView(game: game)
                
            })
            .onTapGesture {
                if appData.resetGame || game.gameEnum != appData.currentGame {
                    appData.ResetGameState()
                }
                appData.currentGame = game.gameEnum
                appData.gamePhases = game.gameEnum.gamePhases
                appData.viewPath.append(game)
            }
        }
        .searchable(text: $gameSearch)
        .onChange(of: gameSearch) {
            filteredGames = gameList.filter{$0.name.contains(gameSearch)}
            if(gameSearch == "") {
                filteredGames = gameList
            }
        }
    }
}


#Preview {
    ContentView()
        .environment(AppData())
}
