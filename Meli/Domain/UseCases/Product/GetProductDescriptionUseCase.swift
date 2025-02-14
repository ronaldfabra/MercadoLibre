//
//  GetProductDescriptionUseCase.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


protocol GetProductDescriptionUseCaseProtocol {
    func execute(productId: String) async throws -> ProductDescriptionDomainModel
}

class GetProductDescriptionUseCase: GetProductDescriptionUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(productId: String) async throws -> ProductDescriptionDomainModel {
        try await repository.getProductDescription(id: productId)
    }
}
