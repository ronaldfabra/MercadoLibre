//
//  GridListStrategy.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftUI

struct GridListStrategy: ProductListViewStrategy {
    func displayList(
        for items: [ProductDomainModel],
        favoritesProductsViewModel: FavoritesProductsViewModel,
        onLastItemVisible: (() -> Void)?
    ) -> AnyView {
        AnyView(
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 150))],
                    spacing: MeliConstants.Dimens.spacing20
                ) {
                    ForEach(items, id: \.id) { product in
                        NavigationLink(value: product) {
                            ProductCell(
                                product: product,
                                isFavorite: favoritesProductsViewModel.isFavorite(productId: product.id),
                                isGrid: true
                            ) {
                                favoritesProductsViewModel.updateFavorite(product: product)
                            }
                            .onAppear {
                                if product == items.last {
                                    onLastItemVisible?()
                                }
                            }
                        }
                    }
                }
                .padding()
            }
                .accessibilityIdentifier("searchProductsGridListView")
        )
    }
}
