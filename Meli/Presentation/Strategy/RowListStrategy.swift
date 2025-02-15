//
//  RowListStrategy.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftUI

struct RowListStrategy: ProductListViewStrategy {
    func displayList(
        for items: [ProductDomainModel],
        favoritesProductsViewModel: FavoritesProductsViewModel,
        onLastItemVisible: (() -> Void)?
    ) -> AnyView {
        AnyView(
            List {
                ForEach(items, id: \.id) { product in
                    ZStack {
                        NavigationLink(value: product) {
                            EmptyView()
                        }
                        .frame(width: .zero, height: .zero)
                        ProductCell(
                            product: product,
                            isFavorite: favoritesProductsViewModel.isFavorite(productId: product.id),
                            isGrid: false
                        ) {
                            favoritesProductsViewModel.updateFavorite(product: product)
                        }
                        .onAppear {
                            if product == items.last {
                                onLastItemVisible?()
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
                .listStyle(.plain)
                .accessibilityIdentifier("searchProductsListView")
        )
    }
}
