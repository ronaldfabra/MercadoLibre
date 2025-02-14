//
//  ProductAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class ProductAdapter: AdapterProtocol {
    typealias T = ProductDto
    typealias U = ProductDomainModel
    
    func adapt(apiResponse: ProductDto) -> ProductDomainModel {
        return ProductDomainModel(
            id: apiResponse.id,
            title: apiResponse.title,
            seller: apiResponse.seller?.toDomain(),
            price: apiResponse.price,
            condition: apiResponse.condition,
            permalink: apiResponse.permalink,
            thumbnail: apiResponse.thumbnail,
            thumbnailId: apiResponse.thumbnailId,
            attributes: apiResponse.attributes.map { $0.toDomain() },
            originalPrice: apiResponse.originalPrice,
            installments: apiResponse.installments?.toDomain(),
            officialStoreName: apiResponse.officialStoreName,
            shipping: apiResponse.shipping.toDomain(),
            order: apiResponse.orderBackend ?? .zero
        )
    }
}
