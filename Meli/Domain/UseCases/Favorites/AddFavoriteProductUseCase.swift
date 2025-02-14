//
//  AddFavoriteProductUseCase.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


protocol AddFavoriteProductUseCaseProtocol {
    func execute(product: ProductDomainModel) throws
}

class AddFavoriteProductUseCase: AddFavoriteProductUseCaseProtocol {
    let repository: FavoriteRepositoryProtocol

    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }

    func execute(product: ProductDomainModel) throws {
        try repository.saveFavoriteProduct(product: product)
    }
}
