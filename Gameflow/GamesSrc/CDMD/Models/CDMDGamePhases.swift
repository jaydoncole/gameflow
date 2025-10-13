//
//  CDMDGamePhases.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

struct CDMDGamePhases {
    var gamePhases: [GamePhase] = []
    
    init() {
        gamePhases = [
            GamePhase(
                phaseId: "action",
                title: "Action",
                details: "Investigator takes 3 actions",
                phaseActions: [
                    GamePhaseAction(name: "Run", helper: "Move up to 3 spaces\nEnemies follow\nTake 1 fire token for each fire token in room when leaving", actionIcon: "figure.run"),
                    GamePhaseAction(name: "Attack", helper: "", actionIcon: "figure.kickboxing"),
                    GamePhaseAction(name: "Rest", helper: "Only in safe space\nHeal 3 stress/wounds", actionIcon: "figure.mind.and.body"),
                    GamePhaseAction(name: "Trade", helper: "Any number of items or companions with any/all investigators in your room", actionIcon: "person.line.dotted.person.fill"),
                    GamePhaseAction(name: "Episode Actions", helper: "", actionIcon: "shoeprints.fill")
                ]
            ),
            GamePhase(
                phaseId: "mythos",
                title: "Mythos",
                details: "Draw mythos card",
                phaseActions: [
                    GamePhaseAction(name: "Draw Mythos", helper: "Keep the Summoning Symbols visible\n\nResolve any special effects on the card\n\nSummon enemies at Gates if indicated on card.")
                ]
            ),
            
            GamePhase(
                phaseId: "inv-or-fight",
                title: "Investigage or Fight",
                details: "Investigate or Fight",
                phaseActions: [
                    GamePhaseAction(name: "Investigate", helper: "If there are no enemies in the space, draw a Discovery card and resolve its effects."),
                    GamePhaseAction(name: "Fight", helper: "If there are enemies in the space, each one attacks the player in the order of the player's choice.\n\nApply any effects on the enemy card.")
                ]
            ),
            
            GamePhase (
                phaseId: "end-of-turn",
                title: "End of Turn",
                details: "End of turn effects",
                phaseActions: [
                    GamePhaseAction(name: "Resolve any end of turn effects", helper: "Check Episode and Discovery cards for any End of Turn Actions (NOT Elder One Actions)"),
                    GamePhaseAction(name: "Fire!", helper: "Roll 1 black dice for each fire token on the character taking damage for each success, then discard the fire token"),
                    GamePhaseAction(name: "Summon Elder One", helper: "If there are three Summoning symbols, move the Elder One figure and token to the right, reshuffle all cards into the Mythos Deck.\n\nIf the Eler One track reaches the red spaces OR the ritual has been disrupted, place the Elder One on the board in the player's space."),
                    GamePhaseAction(name: "Elder One End of Turn Effects", helper: "Check the Elder One stage cards for End of Turn effects for each stage revealed (starting with Stage I, then State II, etc)")
                ]
            )
        ]
    }
}
