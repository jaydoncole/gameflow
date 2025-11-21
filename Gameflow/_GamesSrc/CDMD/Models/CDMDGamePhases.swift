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
                phaseActions: ActionPhaseActionBuilder()
            ),
            GamePhase(
                phaseId: "mythos",
                title: "Mythos",
                details: "Draw mythos card",
                phaseActions: MythosPhaseActionBuilder()
            ),
            
            GamePhase(
                phaseId: "inv-or-fight",
                title: "Investigage or Fight",
                details: "Investigate or Fight",
                phaseActions: InvFightPhaseActionBuilder()
            ),
            
            GamePhase (
                phaseId: "end-of-turn",
                title: "End of Turn",
                details: "End of turn effects",
                phaseActions: EndTurnPhaseActionBulder()
            )
        ]
    }
    
    private func ActionPhaseActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "run",
                name: "Run",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Move up to 3 spaces\nEnemies follow\nTake 1 fire token for each fire token in room when leaving")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "mythos",
                actionIcon: "figure.run",
            ),
            GamePhaseAction(
                actionRef: "attack",
                name: "Attack",
                basicActionElements: [],
                nextScreenType: .NextPhase,
                nextScreenId: "mythos",
                actionIcon: "figure.kickboxing"
            ),
            GamePhaseAction(
                actionRef: "rest",
                name: "Rest",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content:"Only in safe space\nHeal 3 stress/wounds")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "mythos",
                actionIcon: "figure.mind.and.body"
            ),
            GamePhaseAction(
                actionRef: "trade",
                name: "Trade",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph,  content: "Any number of items or companions with any/all investigators in your room")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "mythos",
                actionIcon: "person.line.dotted.person.fill"
            ),
            GamePhaseAction(
                actionRef: "episode_actions",
                name: "Episode Actions",
                basicActionElements: [],
                nextScreenType: .NextPhase,
                nextScreenId: "mythos",
                actionIcon: "shoeprints.fill"
            )
        ]
    }
    
    
    private func MythosPhaseActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "draw_mythos",
                name: "Draw Mythos",
                basicActionElements: [
                    BasicActionElement (
                        elementType: .Paragraph,
                        content: "Keep the Summoning Symbols visible\n\nResolve any special effects on the card\n\nSummon enemies at Gates if indicated on card."
                    )
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "inv-or-fight"
            )
        ]
    }
    
    private func InvFightPhaseActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "investigate",
                name: "Investigate",
                basicActionElements: [
                    BasicActionElement (
                        elementType: .Paragraph,
                        content: "If there are no enemies in the space, draw a Discovery card and resolve its effects."
                    ),
                    BasicActionElement (
                        elementType: .Paragraph,
                        content: "If there are enemies in the space, each one attacks the player in the order of the player's choice.\n\nApply any effects on the enemy card."
                    )
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "end-of-turn"
            ),
        ]
    }
    
    private func EndTurnPhaseActionBulder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "end_of_turn_effects",
                name: "Resolve any end of turn effects",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Check Episode and Discovery cards for any End of Turn Actions (NOT Elder One Actions)" )
                ],
                nextScreenType: .NextAction,
                nextScreenId: "fire"
            ),
            GamePhaseAction(
                actionRef: "fire",
                name: "Fire!",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Roll 1 black dice for each fire token on the character taking damage for each success, then discard the fire token" )
                ],
                nextScreenType: .NextAction,
                nextScreenId: "summon_elder_one"
            ),
            GamePhaseAction(
                actionRef: "summon_elder_one",
                name: "Summon Elder One",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "If there are three Summoning symbols, move the Elder One figure and token to the right, reshuffle all cards into the Mythos Deck.\n\nIf the Eler One track reaches the red spaces OR the ritual has been disrupted, place the Elder One on the board in the player's space." )
                ],
                nextScreenType: .NextAction,
                nextScreenId: "elder_one_end_of_turn"
            ),
            GamePhaseAction(
                actionRef: "elder_one_end_of_turn",
                name: "Elder One End of Turn Effects",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Check the Elder One stage cards for End of Turn effects for each stage revealed (starting with Stage I, then State II, etc)" )
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "action"
            )
        ]
        
    }
}
