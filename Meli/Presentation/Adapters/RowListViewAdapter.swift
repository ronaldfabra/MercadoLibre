//
//  RowListViewAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftUI

struct RowListViewAdapter: ProductListViewAdapter {
    private let strategy: ProductListViewStrategy

    init(strategy: ProductListViewStrategy) {
        self.strategy = strategy
    }

    func getListView(for items: [ProductDomainModel],
                     favoritesProductsViewModel: FavoritesProductsViewModel,
                     onLastItemVisible: (() -> Void)?) -> AnyView {
        strategy
            .displayList(
                for: items,
                favoritesProductsViewModel: favoritesProductsViewModel,
                onLastItemVisible: onLastItemVisible
            )
    }
}
