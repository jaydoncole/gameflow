//
//  ArkhamHorror2edGamePhases.swift
//  Gameflow
//
//  Created by Jaydon Cole on 11/15/25.
//
struct AH2EGamePhases {
    var gamePhases: [GamePhase] = []
    
    init() {
        gamePhases = [
            GamePhase(
                phaseId: "game_setup",
                title: "Game Setup",
                details: "",
                phaseActions: GameSetupActionsBuilder()
            ),
            GamePhase(
                phaseId: "mythos_phase",
                title: "Mythos",
                details: "",
                phaseActions: MythosActionsBuilder()
            ),
            GamePhase(
                phaseId: "upkeep_phase",
                title: "Upkeep",
                details: "",
                phaseActions: UpkeepPhaseActionsBuilder()
             ),
            GamePhase(
                phaseId: "movement_phase",
                title: "Movement",
                details: "",
                phaseActions: MovementPhaseActionBuilder()
            ),
            GamePhase(
                phaseId: "arkham_encounters_phase",
                title: "Arkham Encounters",
                details: "",
                phaseActions: ArkhamEnountersActionBuilder()
            ),
            GamePhase(
                phaseId: "other_world_encounters_phase",
                title: "Other World Encounters",
                details: "",
                phaseActions: OtherWorldActionBuilder()
            ),
            GamePhase(
                phaseId: "turn_end_phase",
                title: "Turn End",
                details: "Pass the First Player marker to the player on the left",
                phaseActions: []
            ),
            GamePhase(
                phaseId: "monster_battle_phase",
                title: "Monster Battle",
                details: "",
                phaseActions: MonsterBattleActionBuilder()
            ),
            GamePhase(
                phaseId: "final_battle_phase",
                title: "Final Battle",
                details: "",
                phaseActions: FinalBattleActionBuilder()
            )
        ]
    }
    
    
    private func GameSetupActionsBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "set_player_order",
                name: "Set Player Order",
                basicActionElements: [],
                nextScreenType: .NextPhase,
                nextScreenId: "mythos_phase"
            ),
        ]
    }
    
    
    private func MythosActionsBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "open_gate_spawn_monsters",
                name: "Open Gate & Spwn Monsters",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Look for the location in the lower left-hand corner of the mythos card."),
                    BasicActionElement(elementType: .CustomButton, content: "Location Has an Elder Sign", customButtonListener: "location_has_elder_sign"),
                    BasicActionElement(elementType: .CustomButton, content: "Location Has an Open Gate", customButtonListener: "location_has_open_gate"),
                    BasicActionElement(elementType: .CustomButton, content: "No Elder Sign or Gate", customButtonListener: "location_has_no_gate"),
                ],
                nextScreenType: .Hidden,
                nextScreenId: "",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "open_gate_elder_sign",
                name: "Open Gate: Location Has Elder Sign",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Gate has been permanently sealed, nothing happens."),
                    BasicActionElement(elementType: .Paragraph, content: "Dunwich Horror: If the location is colered red, a gate burst occurs. Elder Sign is removed and a gate and monster appear. Do not add a doom token to the doom track."),
                    BasicActionElement(elementType: .Paragraph, content: "Innsmouth Horror: Add one token to the Deep Ones Rising track")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "place_clue_token",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "open_gate_gate_exists",
                name: "Open Gate: Location Has an Open Gate",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Monster Surge: Draw monsters equal to the number of gates or number of players (whichever is greater) and placed evenly among gates"),
                    BasicActionElement(elementType: .BulletPoint, content: "If there are more than [[max_monsters]] in the city add monsters to the Outskirts (If Terror Track is 10, there is no monster limit in the city)."),
                    BasicActionElement(elementType: .BulletPoint, content: "If there are more than [[max_outskirts]] in the Outskirts, return all monsters in the Outskirts to the cup, increase the terror level"),
                    BasicActionElement(elementType: .BulletPoint, content: "If Terror Track is already at 10 any increase adds a Doom Token ot the Ancient One's Doom Track."),
                ],
                nextScreenType: .NextAction,
                nextScreenId: "place_clue_token",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "open_gate_no_gate",
                name: "Open Gate: No Gate or Elder Sign",
                basicActionElements: [
                    BasicActionElement(elementType: .BulletPoint, content: "Advance the Doom Track. If the Ancient One Awakes skip reset of Mythos Phase and go directly to the Final Battle"),
                    BasicActionElement(elementType: .BulletPoint, content: "A Gate Opens: First Player draws a gate marker and places it on the location. Discard any Clue tokens at the location. If the Gate opens on an investigator they are immediately drawn through and are Delayed."),
                    BasicActionElement(elementType: .BulletPoint, content: "A Monster Appears: Draw [[monster_draw_number]] and place them at the location"),
                    BasicActionElement(elementType: .BulletPoint, content: "If there are more than [[max_monsters]] in the city add monsters to the Outskirts (If Terror Track is 10, there is no monster limit in the city)."),
                    BasicActionElement(elementType: .BulletPoint, content: "If there are more than [[max_outskirts]] in the Outskirts, return all monsters in the Outskirts to the cup, increase the terror level"),
                    BasicActionElement(elementType: .BulletPoint, content: "If Terror Track is already at 10 any increase adds a Doom Token ot the Ancient One's Doom Track."),
                ],
                nextScreenType: .NextAction,
                nextScreenId: "place_clue_token",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "place_clue_token",
                name: "Place Clue Token",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Place a Clue Token on the indicated space unless there is an Open Gate at that location"),
                    BasicActionElement(elementType: .Paragraph, content: "If one or more investigator are at the location, one of them may immediately take the Clue Token")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "move_monsters",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "move_monsters",
                name: "Move Monsters",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "Move Monsters"),
                    BasicActionElement(elementType: .BulletPoint, content: "Monsters that match the icon on the Mythos card move following the arrows that match the backgroud on the card"),
                    BasicActionElement(elementType: .BulletPoint, content: "Monsters already in a space with an investigator do not move."),
                    BasicActionElement(elementType: .BulletPoint, content: "Monsters with a Yellow Border do not move."),
                    BasicActionElement(elementType: .BulletPoint, content: "Monsters with a Red Border move twice."),
                    BasicActionElement(elementType: .BulletPoint, content: "Monsters with a Green Border have their movement instructions printed on the combat side of their token."),
                    BasicActionElement(elementType: .BulletPoint, content: "Monsters with a Blue Border move to a connected street area with an investigator, or the sky if there are none. Monsters in the sky move to any street area with an investigator.")

                    
                ],
                nextScreenType: .NextAction,
                nextScreenId: "activate_mythos_abilities",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "activate_mythos_abilities",
                name: "Active Mythos Ability",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "**Headline**: Immediately resolve the card and discard."),
                    BasicActionElement(elementType: .Paragraph, content: "**Environment**: Effect stays in play until a new Environment card is draw."),
                    BasicActionElement(elementType: .Paragraph, content: "**Rumor**: Remains in effect until the Pass or Fail condition is met. Only one may be in play at a time."),
                    BasicActionElement(elementType: .Paragraph, content: "**Other Effects**: Some effects may trigger some activity or closed markes, these are discared when the card leaves play.")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "upkeep_phase", // This will be replaced by "turn_end_phase" after the initial Mythos Phase at the beginning of the game is resolved
                actionIcon: ""
            )
            
        ]
    }
    
    
    private func UpkeepPhaseActionsBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "upkeep_action",
                name: "Upkeep",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "Refresh Exhausted Cards"),
                    BasicActionElement(elementType: .Paragraph, content: "Exhausted (face-down) cards are turned face-up"),
                    BasicActionElement(elementType: .Header2, content: "Perform Upkeep Actions"),
                    BasicActionElement(elementType: .Paragraph, content: "Review Investigator cards for upkeep actions that must be performed. Bless, Curse, Bank Loan, and Retainer cards *do not* require a roll during hte first Upkeep Phase after they are acquired."),
                    BasicActionElement(elementType: .Header2, content: "Adjust Skills"),
                    BasicActionElement(elementType: .Paragraph, content: "Move any of the three skill sliders by the number of the Investigator's Focus")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "movement_phase",
                actionIcon: ""
            )
        ]
        
    }
    
    
    private func MovementPhaseActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "movement_phase",
                name: "Movement",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "Arkham Movement"),
                    BasicActionElement(elementType: .Paragraph, content: "Uses move points equal to the player's current Speed"),
                    BasicActionElement(elementType: .Paragraph, content: "When *leaving* a location with one or more monster, the plyer must Evade **each** monster by passing a Sneak check against the moster's awareness (upper right hand corner of Monster's movement side"),
                    BasicActionElement(elementType: .Paragraph, content: "If evade fails, or a the player ends their turn on a space with a monster, they must battle the monster."),
                    BasicActionElement(elementType: .Paragraph, content: "Investigator may pick up a clue token if they *end* their turn in a space with a clue token."),
                    BasicActionElement(elementType: .CustomButton, content: "Battle Monster", customButtonListener: "battle_monster"),
                    BasicActionElement(elementType: .Header2, content: "Other World Movement"),
                    BasicActionElement(elementType: .Paragraph, content: "Investigators in the first are of the Other World move to the second area"),
                    BasicActionElement(elementType: .Paragraph, content: "Investigators int he second area of the Other World moves to a a gate that matches the one they're leaving. Place an explored marker benefit their character")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "arkham_encounters",
                actionIcon: ""
            )
        ]
    }
    
    
    private func ArkhamEnountersActionBuilder() -> [GamePhaseAction] {
        return []
    }
    
    
    private func OtherWorldActionBuilder() -> [GamePhaseAction] {
        return []
    }
    
    
    private func MonsterBattleActionBuilder() -> [GamePhaseAction] {
        return []
    }
    
    
    private func FinalBattleActionBuilder() -> [GamePhaseAction] {
        return []
    }
}
