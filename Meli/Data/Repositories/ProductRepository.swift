//
//  ProductRepository.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class ProductRepository: ProductRepositoryProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func searchProducts(siteId: String, query: String, limit: Int, offset: Int) async throws -> ProductListDomainModel {
        let response = try await network.request(
            endPoint: ProductEndpoint.search(
                siteId: siteId,
                query: query,
                limit: limit,
                offset: offset
            ),
            type: ProductListDto.self
        )
        return response.toDomain()
    }

    func getProductDetail(id: String) async throws -> ProductDetailDomainModel {
        let response = try await network.request(
            endPoint: ProductEndpoint.detail(id: id),
            type: ProductDetailDto.self
        )
        return response.toDomain()
    }

    func getProductDescription(id: String) async throws -> ProductDescriptionDomainModel {
        let response = try await network.request(
            endPoint: ProductEndpoint.description(id: id),
            type: ProductDescriptionDto.self
        )
        return response.toDomain()
    }
}
