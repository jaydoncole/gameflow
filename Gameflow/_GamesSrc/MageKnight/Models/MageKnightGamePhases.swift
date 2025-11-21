//
//  MageKnightGamePhases.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/12/25.
//
struct MageKnightGamePhases {
    
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
                phaseId: "prepare_round",
                title: "Prepare the Round",
                details: "",
                phaseActions: PrepareRoundActionsBuilder()
            ),
            GamePhase(
                phaseId: "choose_tactic_cards",
                title: "Choose Tactic Cards",
                details: "",
                phaseActions: ChooseActionCardsActionBuilder()
            ),
            GamePhase(
                phaseId: "player_actions",
                title: "Player Actions",
                details: "",
                phaseActions: PlayerActionsActionBuilder()
            ),
            GamePhase (
                phaseId: "check_for_end_game",
                title: "Check for End Game",
                details: "Check the scenario description",
                phaseActions: CheckForEndGameActionBuilder()
            )
        ]
    }
    
    private func GameSetupActionsBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "select_scenario",
                name: "Select Scenario",
                basicActionElements: [],
                nextScreenType: .NextAction,
                nextScreenId: "dummy_player"
            ),
            GamePhaseAction(
                actionRef: "dummy_player",
                name: "Dummy Player",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Some scenerios (particularily solo) us a dummy player")
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "choose_tactic_cards"
            )
        ]
    }
    
    private func PrepareRoundActionsBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "flip_day_night",
                name: "Flip the Day/Night Board & Reset the Source",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Flip the Day/Night Board\n\nReroll all mana dice in the Shource")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "new_unit_offer",
                actionIcon: "moon.circle"
            ),
            GamePhaseAction(
                actionRef: "new_unit_offer",
                name: "Create New Unit Offer",
                basicActionElements: [
                    BasicActionElement(elementType: .BulletPoint, content: "Take all Unit cards in offer and put them on the bottom of their deck"),
                    BasicActionElement(elementType: .BulletPoint, content: "If there are Advanced Action cards in the Unit Offer, put them to the bottom of the Advanced Action deck"),
                    BasicActionElement(elementType: .BulletPoint, content: "Deal new Unit cards into the Unit offer equal to number of actual players plus 2"),
                    BasicActionElement(elementType: .BulletPoint, content: "If no Core tile has been revealed, deal Regular Units only."),
                    BasicActionElement(elementType: .BulletPoint, content: "If at least one Core tile has been revealed, alternate Elite and Regular Units"),
                    BasicActionElement(elementType: .BulletPoint, content: "Add one Advanced Action card to the Unit offer for each Monastery that has not been burned"),
                ],
                nextScreenType: .NextAction,
                nextScreenId: "refresh_advanced_action_offer",
                actionIcon: "person.3.fill"
            ),
            GamePhaseAction(
                actionRef: "refresh_advanced_action_offer",
                name: "Refresh the Advanced Action Offer",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Remove the lowest position Advanceed Action card in the offer and put it on the bottom of the Advanced Action deck."),
                    BasicActionElement(elementType: .Paragraph, content: "Move each other Advanceed Action down one position in the offer."),
                    BasicActionElement(elementType: .Paragraph, content: "Draw a new card from the Advanced Action deck and add it to the offer in the top position")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "refresh_spell_offer",
                actionIcon: "arrow.uturn.backward.circle"
            ),
            GamePhaseAction(
                actionRef: "refresh_spell_offer",
                name: "Refresh the Spell Offer",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Remove the lowest position Spell card in the offer and put it on the bottom the Spell deck."),
                    BasicActionElement(elementType: .Paragraph, content: "Move each other Spell down one position in the offer."),
                    BasicActionElement(elementType: .Paragraph, content: "Draw a new card from the Spell deck and add it to the offer in the top position."),

                ],
                nextScreenType: .NextAction,
                nextScreenId: "collect_tactic_cards",
                actionIcon: "wand.and.sparkles"
            ),
            GamePhaseAction(
                actionRef: "collect_tactic_cards",
                name: "Collect Tactic Cards",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Collect all of the tactic cards from the previous Round. Then display the appropriate set of Tactic cards in the game area."),
                ],
                nextScreenType: .NextAction,
                nextScreenId: "player_refresh",
                actionIcon: "lanyardcard.fill"
            ),
            GamePhaseAction(
                actionRef: "player_refresh",
                name: "Player Refresh",
                basicActionElements: [
                    BasicActionElement(elementType: .BulletPoint, content: "Flip all Banner Artifacts and Skill tokens in their play area face up. Player may discard any Banner Artifact assigned to their Units at this time"),
                    BasicActionElement(elementType: .BulletPoint, content: "Readies all Units in their Unit area."),
                    BasicActionElement(elementType: .BulletPoint, content: "Shuffles all their Deed Cards to create a new Deed Deck"),
                    BasicActionElement(elementType: .BulletPoint, content: "Draw Deed cards up to their hand limit: This may be increased if they're next to a keep or city, if next to both use only the higher effect. This may also be increased if they played a \"next time you draw cards\" if that effect occured on the player's final turn of the previous Round"),

                ],
                nextScreenType: .NextPhase,
                nextScreenId: "choose_tactic_cards",
                actionIcon: "person.crop.circle.dashed.circle"
            )
        ]
    }
    
    
    private func ChooseActionCardsActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "choose_tactic_cards",
                name: "Choose Tactic Cards",
                basicActionElements: [
                    BasicActionElement(elementType: .BulletPoint, content: "Player with the lowest Fame chooses first, followed by player with the second lowest fame, etc. In ties, player whose Round Order tocken is lower picks first."),
                    BasicActionElement(elementType: .BulletPoint, content: "Follow any instructions on the Tactic cards which say \"when you take this Tactic\""),
                    BasicActionElement(elementType: .BulletPoint, content: "Rarrange the Round Order tokens according to the Tactic number of eash player, such that the lowest Tactic number is on top (first) and highest Tactic number is on the bottom (last)."),

                ],
                nextScreenType: .NextPhase,
                nextScreenId: "player_actions",
                actionIcon: ""
            )
        ]
    }
    
    
    private func PlayerActionsActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "pre_turn_check",
                name: "Pre-Turn Check",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "Do Any of the Following Apply?", groupName: "pre_turn_check"),
                    BasicActionElement(elementType: .Header3, content: "Round Token is Flipped", groupName: "pre_turn_check"),
                    BasicActionElement(elementType: .BulletPoint, content: "Flip Round Order token back over", groupName: "pre_turn_check"),
                    BasicActionElement(elementType: .BulletPoint, content: "Any Cooperative or interactive skill tokens still in effect will now expire", groupName: "pre_turn_check"),
                    BasicActionElement(elementType: .CustomButton, content: "Round Token Flipped", customButtonListener: "round_token_flipped", groupName: "pre_turn_check"),
                    BasicActionElement(elementType: .Header3, content: "Announcing End of Round", groupName: "announce_end_of_round"),
                    BasicActionElement(elementType: .BulletPoint, content: "You *may* announce End of Round if your deed deck is empty at the start of your turn (but you still have cards in hand). Forfeit the rest of your turn", groupName: "announce_end_of_round"),
                    BasicActionElement(elementType: .BulletPoint, content: "You **must** announce End of Round if you deed deck is empty and you have no cards in your and the start of your turn", groupName: "announce_end_of_round"),
                    BasicActionElement(elementType: .CustomButton, content: "Announce End of Round", customButtonListener: "end_of_round_announced", groupName: "announce_end_of_round")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "turn_type_selector",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "turn_type_selector",
                name: "What Turn Type Are You Taking?",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "What Turn Type Are You Taking?"),
                    BasicActionElement(elementType: .Header3, content: "Rest Turn"),
                    BasicActionElement(elementType: .BulletPoint, content: "Standard Rest: You must discared one non-Wound card and any number of Wound Cards"),
                    BasicActionElement(elementType: .BulletPoint, content: "Slow Recover: You must show your hand to show you have only wound careds. Then, discard one wound card to your discard pile"),
                    BasicActionElement(elementType: .CustomButton, content: "Rest Turn", customButtonListener: "rest_turn"),
                    BasicActionElement(elementType: .Header3, content: "Regular Turn"),
                    BasicActionElement(elementType: .CustomButton, content: "Regular Turn", customButtonListener: "regular_turn")
                ],
                nextScreenType: .Hidden,
                nextScreenId: "",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "regular_turn_movement",
                name: "Regular Turn: Movement",
                basicActionElements: [
                    BasicActionElement(elementType: .BulletPoint, content: "You may play any number of movement cards, use movement skills, or active Units with movement abilities."),
                    BasicActionElement(elementType: .BulletPoint, content: "Spend movement points to move your figure, spending Move points according to the terrain you're moving into."),
                    BasicActionElement(elementType: .BulletPoint, content: "The cost to move into a City is always two"),
                    BasicActionElement(elementType: .BulletPoint, content: "If adjacent to an unreaveled map tile, spend two points to reveal it."),
                    BasicActionElement(elementType: .BulletPoint, content: "You may move through a space containing another character. If do not, or cannot, continue moving from a space containing another character, you attack that character."),
                    BasicActionElement(elementType: .BulletPoint, content: "If you move from a space adjacent to a rampaging monster to another space occupied by the same monster, you are attacked and you movement immediately ends"),
                ] ,
                nextScreenType: .NextAction,
                nextScreenId: "mandetory_actions",
                actionIcon: ""
            ),
            GamePhaseAction(
                actionRef: "mandetory_actions",
                name: "Regular Turn: Mandetory Actions",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "Player vs Player"),
                    BasicActionElement(elementType: .Paragraph, content: "If you ended your movement on a space occupied by another player, you must initiate Player vs. Player"),
                    BasicActionElement(elementType: .CustomButton, content: "Player vs Player", customButtonListener: "player_vs_player"),
                    BasicActionElement(elementType: .Header2, content: "Fortified Site Assault"),
                    BasicActionElement(elementType: .Paragraph, content: "If you entered a fortified site (keep, mage tower, city), you must fight all garrisoned enemies"),
                    BasicActionElement(elementType: .CustomButton, content: "Assault Site", customButtonListener: "assault_site"),
                    BasicActionElement(elementType: .Header2, content: "Attacked by Rampaging Enemies"),
                    BasicActionElement(elementType: .Paragraph, content: "If your movement ended because you were attacked by rampaging enemires, you must fight these enemies"),
                    BasicActionElement(elementType: .CustomButton, content: "Attacked by Enenmy", customButtonListener: "attacked_by_enemy")
                ],
                nextScreenType: .NextAction,
                nextScreenId: "voluntary_actions"
            ),
            GamePhaseAction(
                actionRef: "voluntary_actions" ,
                name: "Regular Turn: Voluntary Actions",
                basicActionElements: [
                    BasicActionElement(elementType: .Header2, content: "Interact with Locals"),
                    BasicActionElement(elementType: .Paragraph, content: "At inhabited sites (village, monastery, keep, mage tower, city) you may interact with the locals."),
                    BasicActionElement(elementType: .CustomButton, content: "Interact with Locals", customButtonListener: "interact_with_locals"),
                    BasicActionElement(elementType: .Header2, content: "Explore Adventure Sites"),
                    BasicActionElement(elementType: .Paragraph, content: "At adventures sites (ruins, dungeon, tomb, monster den, spawning grounds) you may decide to explore them"),
                    BasicActionElement(elementType: .CustomButton, content: "Explore Site", customButtonListener: "explore_site"),
                    BasicActionElement(elementType: .Header2, content: "Challange Rampaging Enemies"),
                    BasicActionElement(elementType: .Paragraph, content: "If there are rampaging enemies in one or more adjacent spaces, you can challenge one or move them in battle."),
                    BasicActionElement(elementType: .CustomButton, content: "Challenge Enemies", customButtonListener: "attacked_by_enemy"),
                    BasicActionElement(elementType: .Header2, content: "Burn Monastery"),
                    BasicActionElement(elementType: .Paragraph, content: "If in a monastery, you may burn it."),
                    BasicActionElement(elementType: .CustomButton, content: "Burn Monastery", customButtonListener: "burn_monastery"),
                    BasicActionElement(elementType: .Header2, content: "Do Nothing"),
                    BasicActionElement(elementType: .CustomButton, content: "Do Nothing", customButtonListener: "do_nothing")
                ],
                nextScreenType: .Hidden,
                nextScreenId: "",
                displayInScrollView: true
            ),
            GamePhaseAction(
                actionRef: "end_of_player_turn",
                name: "End of Player Turn",
                basicActionElements: [
                    BasicActionElement(elementType: .BulletPoint, content: "If a player's Deed deck is empty at the start of their turn, that player may announce the End of Round insteady of playing their turn. Each other player takes on last turn and then the round ends"),
                    BasicActionElement(elementType: .BulletPoint, content: "Check the Scenario End description to see whether the conditions have been met."),
                    BasicActionElement(elementType: .BulletPoint, content: "On a player's last turn, any effects that increase that player's Hand limit carry into the start of the next round.")
                ],
                nextScreenType: .NextPlayer,
                nextScreenId: "playerActions",
                actionIcon: ""
            )
        ]
    }
    
    private func CombatWithEnemiesActionBuilder() -> [GamePhaseAction] {
        return [
            
        ]
    }
    
    private func CheckForEndGameActionBuilder() -> [GamePhaseAction] {
        return [
            GamePhaseAction(
                actionRef: "check_end_of_game",
                name: "Check End of Game Conditions",
                basicActionElements: [
                    BasicActionElement(elementType: .Paragraph, content: "Check for scenario completed conditions or reaching the Round limit. Follow the Scenario description to determine the outcome of the game" )
                ],
                nextScreenType: .NextPhase,
                nextScreenId: "prepare_round",
                actionIcon: ""
            )
        ]
    }
    
}
