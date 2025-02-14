//
//  ProductRepositoryProtocol.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


protocol ProductRepositoryProtocol {
    func searchProducts(siteId: String, query: String, limit: Int, offset: Int) async throws -> ProductListDomainModel
    func getProductDetail(id: String) async throws -> ProductDetailDomainModel
    func getProductDescription(id: String) async throws -> ProductDescriptionDomainModel
}
