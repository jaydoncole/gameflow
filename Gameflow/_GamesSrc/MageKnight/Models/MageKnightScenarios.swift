//
//  Scenarios.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/15/25.
//

struct MageKnightScenarios {
    var scenarios: [MageKnightScenario] = [
        MageKnightScenario(
            scenarioId: "first_reconnaissance",
            name: "First Reconnaissance",
            expansion: .BaseGame,
            players: [1, 2, 3, 4],
            type: [.Competative],
            length: "Three rounds (2 days 1 night)",
            days: 2,
            nights: 1
        ),
        MageKnightScenario(
            scenarioId: "full_conquest",
            name: "Full Conquest",
            expansion: .BaseGame,
            players: [2, 3, 4],
            type: [.Competative],
            length: "Six rounds (3 days and 3 nights)",
            days: 3,
            nights: 3
        ),
        MageKnightScenario (
            scenarioId: "blitz_conquest",
            name: "Blitz Conquest",
            expansion: .BaseGame,
            players: [2, 3, 4],
            type: [.Competative],
            length: "Four rounds (2 days and 2 nights)",
            days: 2,
            nights: 2
        ),
        MageKnightScenario (
            scenarioId: "solo_conquest",
            name: "Solo Conquest",
            expansion: .BaseGame,
            players: [1],
            type: [.Solo],
            length: "Sixe rounds (3 days and 3 nights)",
            days: 3,
            nights: 3
        ),
        MageKnightScenario (
            scenarioId: "full_cooperation",
            name: "Full Cooperation",
            expansion: .BaseGame,
            players: [2, 3],
            type: [.Cooperative],
            length: "Six rounds (3 days, 3 nights)",
            days: 3,
            nights: 3
        ),
        MageKnightScenario (
            scenarioId: "mines_liberation",
            name: "Mines Liberation",
            expansion: .BaseGame,
            players: [2, 3, 4],
            type: [.Competative],
            length: "Four rounds (2 days, 2 nights)",
            days: 2,
            nights: 2
        ),
        MageKnightScenario (
            scenarioId: "druid_nights",
            name: "Druid Nights",
            expansion: .BaseGame,
            players: [2, 3, 4],
            type: [.Competative],
            length: "Four rounds (2 days, 2 nights)",
            days: 2,
            nights: 2
        ),
        MageKnightScenario (
            scenarioId: "dungeon_lords",
            name: "Dungeon Lords",
            expansion: .BaseGame,
            players: [2, 3, 4],
            type: [.Competative],
            length: "Five rounds (3 days, 2 nights)",
            days: 3,
            nights: 2
        ),
        MageKnightScenario (
            scenarioId: "conquer_and_hold",
            name: "Conquer and Hold",
            expansion: .BaseGame,
            players: [2, 4],
            type: [.Competative],
            length: "Four rounds (4 players), six rounds (2 players)",
            days: 3,
            nights: 3
        ),
        MageKnightScenario (
            scenarioId: "one_to_return",
            name: "One to Return",
            expansion: .BaseGame,
            players: [2, 3, 4],
            type: [.Competative],
            length: "Four rounds (2 days, 2 nights)",
            days: 2,
            nights: 2
        ),
        MageKnightScenario (
            scenarioId: "volkares_return_epic",
            name: "Volkare's Return - Epic",
            expansion: .TheLostLegion,
            players: [1, 2, 3, 4],
            type: [.Cooperative, .Solo],
            length: "Six rounds (3 days, 3 nights)",
            days: 3,
            nights: 3
        ),
        MageKnightScenario (
            scenarioId: "volkares_return_blitz",
            name: "Volkare's Return - Blitz",
            expansion: .TheLostLegion,
            players: [1, 2, 3, 4],
            type: [.Cooperative, .Solo],
            length: "Four rounds (2 days, 2 nights)",
            days: 2,
            nights: 2
        ),
        MageKnightScenario (
            scenarioId: "volkares_quest",
            name: "Volkare's Quest",
            expansion: .TheLostLegion,
            players: [1, 2, 3, 4],
            type: [.Cooperative, .Solo],
            length: "Six rounds (3 days, 3 nights)",
            days: 3,
            nights: 3
       ),
        MageKnightScenario (
            scenarioId: "life_and_death",
            name: "Life and Death",
            expansion: .ShadesOfTezla,
            players: [1, 2, 3, 4],
            type: [.Cooperative, .Competative, .Solo],
            length: "Six rounds (3 days, 3 nights)",
            days: 3,
            nights: 3
        ),
        MageKnightScenario (
            scenarioId: "realm_of_the_dead",
            name: "The Realm of the Dead",
            expansion: .ShadesOfTezla,
            players: [1, 2, 3, 4],
            type: [.Cooperative, .Competative, .Solo],
            length: "Four rounds (2 days, 2 nights)",
            days: 2,
            nights: 2
        ),
        MageKnightScenario (
            scenarioId: "hidden_valley",
            name: "The Hidden Valley",
            expansion: .ShadesOfTezla,
            players: [1 , 2, 3, 4],
            type: [.Cooperative, .Competative, .Solo],
            length: "Four rounds (2 days, 2 nights)",
            days: 2,
            nights: 2
        ),
        MageKnightScenario (
            scenarioId: "lost_relic",
            name: "The Lost Relic",
            expansion: .ShadesOfTezla,
            players: [1, 2, 3, 4],
            type: [.Cooperative, .Competative, .Solo],
            length: "Two rounds (1 day, 1 night)",
            days: 1,
            nights: 1
        )
    ]
    
}

