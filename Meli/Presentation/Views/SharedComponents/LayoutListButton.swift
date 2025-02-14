//
//  LayoutListButton.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftUI

struct LayoutListButton: View {

    var isGrid: Bool
    var onButtonPressed: (() -> Void)? = nil

    var body: some View {

        HStack(spacing: MeliConstants.Dimens.spacing10) {
            VStack(spacing: MeliConstants.Dimens.spacing10) {
                ZStack {
                    Image(systemName: MeliConstants.Icons.list)
                        .opacity(isGrid ? 1 : .zero)
                        .scaleEffect(isGrid ? 1.0 : .zero)

                    Image(systemName: MeliConstants.Icons.grid)
                        .opacity(isGrid ? .zero : 1)
                        .scaleEffect(isGrid ? .zero : 1.0)
                }
                .animation(.bouncy, value: isGrid)
            }
            Text(MeliConstants.Strings.layoutType)
                .font(.system(size: MeliConstants.Values.value10,
                              weight: .regular))
        }
        .onTapGesture {
            onButtonPressed?()
        }
        .padding(MeliConstants.Dimens.spacing8)
        .background(Capsule().stroke(Color.black, lineWidth: 1))
        .clipShape(Capsule())
    }
}

#Preview {
    @Previewable @State var isGrid: Bool = false
    LayoutListButton(isGrid: isGrid) {
        isGrid = !isGrid
    }
}
