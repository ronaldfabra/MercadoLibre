//
//  DeleteFavoriteProductUseCase.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


protocol DeleteFavoriteProductUseCaseProtocol {
    func execute(productId: String) throws
}

class DeleteFavoriteProductUseCase: DeleteFavoriteProductUseCaseProtocol {
    let repository: FavoriteRepositoryProtocol
    
    init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(productId: String) throws {
        try repository.removeProduct(productId: productId)
    }
}
