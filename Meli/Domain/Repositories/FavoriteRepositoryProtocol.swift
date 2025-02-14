//
//  FavoriteRepositoryProtocol.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


protocol FavoriteRepositoryProtocol {
    func getAllFavoritesProducts() throws -> [ProductDomainModel]
    func saveFavoriteProduct(product: ProductDomainModel) throws
    func removeProduct(productId: String) throws
}
