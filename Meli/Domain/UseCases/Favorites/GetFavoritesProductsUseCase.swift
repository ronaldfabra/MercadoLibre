//
//  GetFavoritesProductsUseCase.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


protocol GetFavoritesProductsUseCaseProtocol {
    func execute() throws -> [ProductDomainModel]
}

class GetFavoritesProductsUseCase: GetFavoritesProductsUseCaseProtocol {
    let repository: FavoriteRepositoryProtocol

    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }

    func execute() throws -> [ProductDomainModel] {
        try repository.getAllFavoritesProducts()
    }
}
