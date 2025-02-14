//
//  FavoriteRepository.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class FavoriteRepository: FavoriteRepositoryProtocol {
    private let database: MeliModelContainerProtocol

    init(database: MeliModelContainerProtocol) {
        self.database = database
    }

    func getAllFavoritesProducts() throws -> [ProductDomainModel] {
        try database.getAllFavoritesProducts()
    }

    func saveFavoriteProduct(product: ProductDomainModel) throws {
        try database.saveProduct(product: product)
    }

    func removeProduct(productId: String) throws {
        try database.removeProduct(productId: productId)
    }
}
