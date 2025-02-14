//
//  SearchProductsUseCaseProtocol.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


protocol SearchProductsUseCaseProtocol {
    func execute(siteId: String, query: String, limit: Int, offset: Int) async throws -> ProductListDomainModel
}

class SearchProductsUseCase: SearchProductsUseCaseProtocol {
    private let repository: ProductRepositoryProtocol
    
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(siteId: String, query: String, limit: Int, offset: Int) async throws -> ProductListDomainModel {
        try await repository.searchProducts(siteId: siteId, query: query, limit: limit, offset: offset)
    }
}
