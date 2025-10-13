//
//  ButtonStyles.swift
//  Gameflow
//
//  Created by Jaydon Cole on 10/4/25.
//

import SwiftUI

struct PositiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .bold()
            .foregroundStyle(.white)
            .background(Color.accentColor)
            .clipShape(Capsule(style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PositiveButtonStyle {
    static var positiveButtonStyle: PositiveButtonStyle {.init()}
}
