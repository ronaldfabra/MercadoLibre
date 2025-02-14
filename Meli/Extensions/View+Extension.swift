//
//  View+Extension.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

extension View {
    func shimmering() -> some View {
        self.overlay(
            LinearGradient(
                gradient: Gradient(colors: [Color.white.opacity(0.4), Color.white.opacity(0.2), Color.white.opacity(0.4)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .rotationEffect(.degrees(30))
            .offset(x: -200, y: -200)
            .mask(self)
            .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: UUID())
        )
    }

    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}
