//
//  FavoriteRepositoryMock.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Foundation

class FavoriteRepositoryMock: FavoriteRepositoryProtocol {

    var favoriteList: [ProductDomainModel] = []

    func getAllFavoritesProducts() throws -> [ProductDomainModel] {
        favoriteList
    }

    func saveFavoriteProduct(product: ProductDomainModel) throws {
        if product.id.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            favoriteList.append(product)
        }
    }

    func removeProduct(productId: String) throws {
        if let index = favoriteList.firstIndex(where: { $0.id == productId }) {
            favoriteList.remove(at: index)
        }
    }
}
