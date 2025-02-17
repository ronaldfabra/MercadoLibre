//
//  ColoredNavigationBar.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 16/02/25.
//

import SwiftUI

extension View {
    func navigationBar(_ background: Color = .yellow) -> some View {
        return self
            .modifier(ColoredNavigationBar(background: background))
    }
}

struct ColoredNavigationBar: ViewModifier {
    var background: Color

    func body(content: Content) -> some View {
        content
            .toolbarBackground(background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
