//
//  ProductListViewStrategy.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftUI

protocol ProductListViewStrategy {
    func displayList(for items: [ProductDomainModel],
                     favoritesProductsViewModel: FavoritesProductsViewModel,
                     onLastItemVisible: (() -> Void)?) -> AnyView
}
