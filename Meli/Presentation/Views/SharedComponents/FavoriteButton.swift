//
//  FavoriteButton.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

struct FavoriteButton: View {

    var isFavorite: Bool
    var onButtonPressed: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: MeliConstants.Dimens.spacing10) {
            ZStack {
                Image(systemName: MeliConstants.Icons.favorite)
                    .opacity(isFavorite ? 1 : .zero)
                    .scaleEffect(isFavorite ? 1.0 : .zero)
                    .foregroundColor(Color.red)

                Image(systemName: MeliConstants.Icons.notFavorite)
                    .opacity(isFavorite ? .zero : 1)
                    .scaleEffect(isFavorite ? .zero : 1.0)
            }
        }
        .padding(MeliConstants.Dimens.spacing10)
        .animation(.bouncy, value: isFavorite)
        .onTapGesture {
            onButtonPressed?()
        }
        .background(Color.gray.opacity(0.2))
        .containerShape(.circle)
    }
}

#Preview {
    @Previewable @State var isFavorite: Bool = false
    FavoriteButton(isFavorite: isFavorite) {
        isFavorite = !isFavorite
    }
}
