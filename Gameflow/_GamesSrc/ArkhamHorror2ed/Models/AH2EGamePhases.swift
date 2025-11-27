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
                phaseId: "lost_in_time_and_space_phase_one",
                title: "Movement: Lost in Time and Space",
                details: "",
                phaseActions: LostInTimeSpaceStageOneActionBuilder()
            ),
            GamePhase(
                phaseId: "lost_in_time_and_space_phase_two",
                title: "Movement: Lost in Time and Space",
                details: "",
                phaseActions: LostInTimeSpaceStageTwoActionBuilder()
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
                title: "Turn End Phase",
                details: "",
                phaseActions: TurnEndActionBuilder()
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
    
    
    /**
     GAME SETUP ACTIONS BUILDER
     For PhaseId: game_setup
     */
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
    /** END GAME SETUP ACTIONS BUILDER*/
    
    
    /**
     MYTHOS PHASE ACTIONS BUILDER
     For PhaseId: mythos_phase
     */
    private func MythosActionsBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "open_gate_spawn_monsters",
                name: "Open Gate & Spawn Monsters",
                basicActionElements: MythosPhaseOpenGateBasicActionsBuilder(),
                nextScreenType: .Hidden,
                nextScreenId: "",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "open_gate_elder_sign",
                name: "Open Gate: Location Has Elder Sign",
                basicActionElements: MythosPhaseOpenGateHasElderSignBasicActionsBuilder(),
                nextScreenType: .NextAction,
                nextScreenId: "place_clue_token",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "open_gate_gate_exists",
                name: "Open Gate: Location Has an Open Gate",
                basicActionElements: MythosPhaseOpenGateHasOpenGateActionsBuilder(),
                nextScreenType: .NextAction,
                nextScreenId: "place_clue_token",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "open_gate_no_gate",
                name: "Open Gate: No Gate or Elder Sign",
                basicActionElements: MythosPhaseOpenGateHasNoGateActionsBuilder(),
                nextScreenType: .NextAction,
                nextScreenId: "place_clue_token",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "place_clue_token",
                name: "Place Clue Token",
                basicActionElements: MythosPhasePlaceCluesActionsBuilder(),
                nextScreenType: .NextAction,
                nextScreenId: "move_monsters",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "move_monsters",
                name: "Move Monsters",
                basicActionElements: MythosPhaseMoveMonstersActionsBuilder(),
                nextScreenType: .NextAction,
                nextScreenId: "activate_mythos_abilities",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "activate_mythos_abilities",
                name: "Active Mythos Ability",
                basicActionElements: MythosPhaseActivateMythosAbilitiesAcitonsBuilder(),
                nextScreenType: .NextPhase,
                // This will be replaced by "turn_end_phase" after the initial Mythos Phase at the beginning of the game is resolved
                nextScreenId: "upkeep_phase",
                actionIcon: ""
            )
        ]
    }
    
    // Basic Actions Builder for open_gate_spawn_monsters
    private func MythosPhaseOpenGateBasicActionsBuilder() -> [BasicActionElement] {
        return [
            BasicActionElement(elementType: .Paragraph, content: "Look for the location in the lower left-hand corner of the mythos card."),
            BasicActionElement(elementType: .CustomButton, content: "Location Has an Elder Sign", customButtonListener: "location_has_elder_sign"),
            BasicActionElement(elementType: .CustomButton, content: "Location Has an Open Gate", customButtonListener: "location_has_open_gate"),
            BasicActionElement(elementType: .CustomButton, content: "No Elder Sign or Gate", customButtonListener: "location_has_no_gate"),
        ]
    }
    
    // Basic Actions Builder for open_gate_elder_sign
    private func MythosPhaseOpenGateHasElderSignBasicActionsBuilder() -> [BasicActionElement] {
        return [
            BasicActionElement(elementType: .Paragraph, content: "Gate has been permanently sealed, nothing happens."),
            BasicActionElement(elementType: .Paragraph, content: "Dunwich Horror: If the location is colered red, a gate burst occurs. Elder Sign is removed and a gate and monster "
                               + "appear. Do not add a doom token to the doom track."),
            BasicActionElement(elementType: .Paragraph, content: "Innsmouth Horror: Add one token to the Deep Ones Rising track")
        ]
    }
    
    // Basic Actions Builder for open_gate_gate_exists
    private func MythosPhaseOpenGateHasOpenGateActionsBuilder() -> [BasicActionElement] {
        return [
            BasicActionElement(elementType: .Paragraph, content: "Monster Surge: Draw monsters equal to the number of gates or number of players (whichever is greater) and placed evenly among gates"),
            BasicActionElement(elementType: .BulletPoint, content: "If there are more than [[max_monsters]] in the city add monsters to the Outskirts (If Terror Track is 10, there is no monster limit in the city)."),
            BasicActionElement(elementType: .BulletPoint, content: "If there are more than [[max_outskirts]] in the Outskirts, return all monsters in the Outskirts to the cup, increase the terror level"),
            BasicActionElement(elementType: .BulletPoint, content: "If Terror Track is already at 10 any increase adds a Doom Token ot the Ancient One's Doom Track."),
        ]
    }
    
    // Basic Actions Builder for open_gate_no_gate
    private func MythosPhaseOpenGateHasNoGateActionsBuilder() -> [BasicActionElement] {
        return [
            BasicActionElement(elementType: .BulletPoint, content: "Advance the Doom Track. If the Ancient One Awakes skip reset of Mythos Phase and go directly to the Final Battle"),
            BasicActionElement(elementType: .BulletPoint, content: "A Gate Opens: First Player draws a gate marker and places it on the location. Discard any Clue tokens at the location. If the Gate opens on an investigator they are immediately drawn through and are Delayed."),
            BasicActionElement(elementType: .BulletPoint, content: "A Monster Appears: Draw [[monster_draw_number]] and place them at the location"),
            BasicActionElement(elementType: .BulletPoint, content: "If there are more than [[max_monsters]] in the city add monsters to the Outskirts (If Terror Track is 10, there is no monster limit in the city)."),
            BasicActionElement(elementType: .BulletPoint, content: "If there are more than [[max_outskirts]] in the Outskirts, return all monsters in the Outskirts to the cup, increase the terror level"),
            BasicActionElement(elementType: .BulletPoint, content: "If Terror Track is already at 10 any increase adds a Doom Token ot the Ancient One's Doom Track.")
        ]
    }
    
    // Basic Actions Builder for place_clue_token
    private func MythosPhasePlaceCluesActionsBuilder() -> [BasicActionElement] {
        return [
            BasicActionElement(elementType: .Paragraph, content: "Place a Clue Token on the indicated space unless there is an Open Gate at that location"),
            BasicActionElement(elementType: .Paragraph, content: "If one or more investigator are at the location, one of them may immediately take the Clue Token")
        ]
    }
    
    // Basic Actions Builder for move_monsters
    private func MythosPhaseMoveMonstersActionsBuilder() -> [BasicActionElement] {
        return [
            BasicActionElement(elementType: .BulletPoint, content: "Monsters that match the icon on the Mythos card move following the arrows that match the backgroud on the card"),
            BasicActionElement(elementType: .BulletPoint, content: "Monsters already in a space with an investigator do not move."),
            BasicActionElement(elementType: .BulletPoint, content: "Monsters with a Yellow Border do not move."),
            BasicActionElement(elementType: .BulletPoint, content: "Monsters with a Red Border move twice."),
            BasicActionElement(elementType: .BulletPoint, content: "Monsters with a Green Border have their movement instructions printed on the combat side of their token."),
            BasicActionElement(elementType: .BulletPoint, content: "Monsters with a Blue Border move to a connected street area with an investigator, or the sky if there are none. Monsters in the sky move to any street area with an investigator.")
        ]
    }
    
    // Basic Actions Builder for activate_mythos_abilities
    private func MythosPhaseActivateMythosAbilitiesAcitonsBuilder() -> [BasicActionElement] {
        return [
            BasicActionElement(elementType: .Paragraph, content: "**Headline**: Immediately resolve the card and discard."),
            BasicActionElement(elementType: .Paragraph, content: "**Environment**: Effect stays in play until a new Environment card is draw."),
            BasicActionElement(elementType: .Paragraph, content: "**Rumor**: Remains in effect until the Pass or Fail condition is met. Only one may be in play at a time."),
            BasicActionElement(elementType: .Paragraph, content: "**Other Effects**: Some effects may trigger some activity or closed markes, these are discared when the card leaves play.")
        ]
    }
    /* END MYTHOS PHASE ACTIONS BUILDER */
    
    
    /**
     UPKEEP PHASE ACTIONS BUILDER
     For phaseId: upkeep_phase
     */
    
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
   /* DONE UPKEEP PHASE ACTIONS BUILDER */

    
    /**
         MOVEMENT PHASE ACTIONS BUILDER
     */
    private func MovementPhaseActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "movement_action_arkham_movement",
                name: "Movement: Arkham",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Uses move points equal to the player's current Speed"),
                    BasicActionElement(elementType: .Paragraph, content: "When *leaving* a location with one or more monster, the plyer must Evade **each** monster by passing a Sneak check against the moster's awareness (upper right hand corner of Monster's movement side"),
                    BasicActionElement(elementType: .Paragraph, content: "If evade fails, or a the player ends their turn on a space with a monster, they must battle the monster."),
                    BasicActionElement(elementType: .Paragraph, content: "Investigator may pick up a clue token if they *end* their turn in a space with a clue token."),
                    BasicActionElement(elementType: .CustomButton, content: "Battle Monster", customButtonListener: "battle_monster"),
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "movement_phase",
                lastPlayerNextScreenId: "arkham_encounters_phase",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "movement_action_other_world_movement",
                name: "Movement: Other World",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Investigators in the first are of the Other World move to the second area"),
                    BasicActionElement(elementType: .Paragraph, content: "Investigators in the second area of the Other World moves to a a gate that matches the one they're leaving. Place an explored marker benefit their character")
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "movement_phase",
                lastPlayerNextScreenId: "arkham_encounters_phase",
                actionIcon: ""
            )
            
        ]
    }
    
    private func LostInTimeSpaceStageOneActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "movement_action_lost_in_time_and_space_one",
                name: "Movement Action: Lost In Time And Space",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Stand the investigator figure upright.")
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "movement_phase",
                lastPlayerNextScreenId: "arkham_encounters_phase",
                actionIcon: "",
            )
        ]
    }
    private func LostInTimeSpaceStageTwoActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "movement_action_lost_in_time_and_space_two",
                name: "Movement Action: Lost In Time And Space",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Investigator may move from Lost in Time and Space to any place in Arkham.")
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "movement_phase",
                lastPlayerNextScreenId: "arkham_encounters_phase",
                actionIcon: ""
            )
        ]
    }

    
    private func ArkhamEnountersActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "arkham_encounters_no_gate",
                name: "No Gate",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Investigator may use a special ability available at the location instead of having an encounter there."),
                    BasicActionElement(elementType: .Paragraph, content: "Shuffle location deck corresponding to the neighborhoo the investigator is in and find the entry for the investigator's location."),
                    BasicActionElement(elementType: .Paragraph, content: "A monster or gate may not appear in a sealed location, even if directed by the card."),
                    BasicActionElement(elementType: .Paragraph, content: "If I a Monster Appears investigator must immediately evade or fight. Regardless of outcome the monster is returned afterwards"),
                    BasicActionElement(elementType: .CustomButton, content: "Battle Monster", customButtonListener: "battle_monster"),
                    
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "arkham_enounters_phase",
                lastPlayerNextScreenId: "other_world_encounters_phase",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "arkham_encounters_gate_no_marker",
                name: "Gate - No Explored Marker",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "No Explored Marker"),
                    BasicActionElement(elementType: .Paragraph, content: "Investigator is immediately drawn through the gate to left area of the Other World indicated by the gate marker."),
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "arkham_encounters_phase",
                lastPlayerNextScreenId: "other_world_encounters_phase",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "arkham_encounters_gate_marker",
                name: "Gate - Explored Marker",
                basicActionElements: [
                    BasicActionElement(elementType: .Header3, content: "Close Gate"),
                    BasicActionElement(elementType: .Paragraph, content: "Investigator may close the gate by passing a Lore or a Fight check using the number printed on the Gate Marker as the modifier."),
                    BasicActionElement(elementType: .Header3, content: "Seal Gate"),
                    BasicActionElement(elementType: .BulletPoint, content: "Succeeding at close gate check, then spend 5 Clue Tokens. Investiagor takes Gate Marker and places *unused* Elder Sign token  on the location."),
                    BasicActionElement(elementType: .BulletPoint, content: "Using an Elder Sign card (no roll is needed), return the Elder Sign card to the box. Take Gate Marker. Take 1 Doom Token from the Ancient One's terror track and place it on the location.")
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "arkham_encounters_phase",
                lastPlayerNextScreenId: "other_world_encounters_phase",
                actionIcon: ""
            )
        ]
    }
    
    
    private func OtherWorldActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "other_worlds_encounters_phase",
                name: "Other Worlds Enounters Phase",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Investigator draws from the Gate Deck until they find a card whose color matches one of the Encounter Symbol colors on the gate."),
                    BasicActionElement(elementType: .Paragraph, content: "Player looks if there is a specific encounter for the Other World his investigator is currently in and performs the actions indicated by the card. If there is no specific encounter, player performs the \"Other\" actions."),
                    BasicActionElement(elementType: .Paragraph, content: "If a Monster Appears the investigator must immediately fight or evade the monster. Regardless of outcome the monster returns to the monster cup afterwards"),
                    BasicActionElement(elementType: .CustomButton, content: "Battle Monster", customButtonListener: "battle_monster")
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "other_worlds_encounters_phase",
                lastPlayerNextScreenId: "mythos_phase",
                actionIcon: ""
            )
        ]
    }
    
    
    private func TurnEndActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "turn_end",
                name: "Turn End",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Pass the First Player Marker to the left.")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "upkeep_phase",
                actionIcon: ""
            )
        ]
    }
    
    private func MonsterBattleActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "horror_check",
                name: "Horror Check",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Make a skill Will check modified by the monster's horror rating (found in the lower-left corner of Monster's combat side."),
                    BasicActionElement(elementType: .Paragraph, content: "If the investigator fails the check, they lose Sanity show underneat the monster's horror rating."),
                    BasicActionElement(elementType: .Paragraph, content: "If a player's Sanity is reduced to 0: "),
                    BasicActionElement(elementType: .Header2, content: "Insane in Arkham"),
                    BasicActionElement(elementType: .Paragraph, content: "Player discards half of their items and clue tokens (rounded down), as well as all retainers. Player immediately moves to Arkham Asylumn and restores Sanity to 1"),
                    BasicActionElement(elementType: .Header2, content: "Insane in Other World"),
                    BasicActionElement(elementType: .Paragraph, content: "Investigator moves to Lost in Time and Space area, laying their marker down and discarding half of their items and clue tokens (rounded down), as well as all their retainers."),
                    BasicActionElement(elementType: .Paragraph, content: "On the next movement phase the character may stand their marker back-up"),
                    BasicActionElement(elementType: .Paragraph, content: "On the turn after standing their marker up, investigator moves to any location in Arkham"),
                    BasicActionElement(elementType: .CustomButton, content: "Lost in Time and Space", customButtonListener: "lost_in_time_and_space")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "fight_or_flee",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "fight_or_flee",
                name: "Fight or Flee",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "Flee"),
                    BasicActionElement(elementType: .Paragraph, content: "Investigator may attempt to evade the monster by making a Sneack check modified by the monster's Awarness value (upper-right corner of the monster's movement side)"),
                    BasicActionElement(elementType: .Paragraph, content: "If the Investigator fails the checkk, the monster immediately deals damage and the battle continues."),
                    BasicActionElement(elementType: .Header2, content: "Fight"),
                    BasicActionElement(elementType: .Paragraph, content: "Player makes Combat check with their Fight value, modified by the monster's combat rating (printed in the lower-right corner of the combat side). The difficulty is equal to the monster's toughness (represented by the number of \"blood drop\" icons in the lower center of the combat side."),
                    BasicActionElement(elementType: .Paragraph, content: "If the monster's toughness is greater than 1, partial success has no effect on the moster.")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "monster_damage",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "monster_damage",
                name: "Monster Damage",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Investigator loses Stamina equal to the number printed below Monster's combat rating (lower-right corner of the combat side.)"),
                    BasicActionElement(elementType: .Paragraph, content: "If an investigator is reduced to 0 stamina they are unconcous."),
                    BasicActionElement(elementType: .Header2, content: "Unconcious in Arkham"),
                    BasicActionElement(elementType: .Paragraph, content: "Player discards half of their items and Clue tokens (rounded down), along with all retainers. Player moves investigator to St. Mary's Hospital and restored to 1 stamina."),
                    BasicActionElement(elementType: .Header2, content: "Unconcious in Other World"),
                    BasicActionElement(elementType: .Paragraph, content: "Discard half of investigators items and Clue tokens, as well as all retainers. Restore Stamina to 1 and move to Lost in Time and Space and is delayed (lay down marker). Player may only stand on the next movement phase. The following turn the investigator moves to any location or street area in Arkham."),
                    BasicActionElement(elementType: .CustomButton, content: "Lost in Time and Space", customButtonListener: "lost_in_time_and_space"),
                    BasicActionElement(elementType: .CustomButton, content: "Continue Battle or Battle Next Monster", customButtonListener: "battle_monster")
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "movement_phase",
                lastPlayerNextScreenId: "arkham_encounters_phase",
                actionIcon: ""
            )
        ]
    }
    
    
    private func FinalBattleActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "investigators_refresh",
                name: "Investigators Refresh",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "Refresh Exhausted Cards"),
                    BasicActionElement(elementType: .Paragraph, content: "Exhausted (face-down) cards are turned face-up"),
                    BasicActionElement(elementType: .Header2, content: "Perform Upkeep Actions"),
                    BasicActionElement(elementType: .Paragraph, content: "Review Investigator cards for upkeep actions that must be performed. Bless, Curse, Bank Loan, and Retainer cards *do not* require a roll during hte first Upkeep Phase after they are acquired."),
                    BasicActionElement(elementType: .Header2, content: "Adjust Skills"),
                    BasicActionElement(elementType: .Paragraph, content: "Move any of the three skill sliders by the number of the Investigator's Focus"),
                    BasicActionElement(elementType: .Paragraph, content: "Investigators may also trade itmes as if they were in the same location."),
                    BasicActionElement(elementType: .Paragraph, content: "First Player marker gets passed to the next player on the left.")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "investigators_attack",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "investigators_attack",
                name: "Investigators Attack",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Make a Combat Check against the Ancient One using its combat rating as the modifier"),
                    BasicActionElement(elementType: .Paragraph, content: "Track the number of successfull attacks, when [[player_num]] attacks have have succeeded, remove one ddtoken from the Doom Track until all tokens are removed or all players are killed.")
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "investigators_attack",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "ancient_one_attacks",
                name: "Ancient One Attacks",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "The Ancient One makes an attack on each of the living investigators."),
                    BasicActionElement(elementType: .Paragraph, content: "Any investigator reduced to 0 stamina or 0 sanity is immediately devoured and eliminated from the game."),
                    BasicActionElement(elementType: .CustomButton, content: "Player Devoured", customButtonListener: "player_devoured")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "final_battle_phase",
                actionIcon: ""
            )
        ]
    }
}
