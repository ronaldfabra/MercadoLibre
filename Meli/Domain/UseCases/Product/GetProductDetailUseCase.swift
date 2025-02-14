//
//  GetProductDetailUseCase.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


protocol GetProductDetailUseCaseProtocol {
    func execute(productId: String) async throws -> ProductDetailDomainModel
}

class GetProductDetailUseCase: GetProductDetailUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(productId: String) async throws -> ProductDetailDomainModel {
        try await repository.getProductDetail(id: productId)
    }
}
