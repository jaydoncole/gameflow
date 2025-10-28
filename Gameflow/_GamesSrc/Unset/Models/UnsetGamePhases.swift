//
//  UnsetGamePhases.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/11/25.
//

struct UnsetGamePhases {
    var gamePhases: [GamePhase] = [
        GamePhase(
            phaseId: "Sample",
            title: "Sample Phase",
            details: "This is a sample phase",
            phaseActions: [
                GamePhaseAction(
                    actionRef: "sample",
                    name: "Sample",
                    basicActionElements: [
                        BasicActionElement(elementType: .Paragraph, content: "This is a sample action.")
                    ],
                    actionIcon: "figure.run"
                ),
            ]
        ),
    ]
}
