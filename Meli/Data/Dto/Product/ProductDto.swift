//
//  ProductDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


struct ProductDto: DTOProtocol {
    let id: String
    let title: String
    let seller: SellerDto?
    let price: Double
    let condition: String
    let permalink: String
    let thumbnail: String
    let thumbnailId: String?
    let attributes: [ProductAttributeDto]
    let originalPrice: Double?
    let installments: ProductInstallmentDto?
    let officialStoreName: String?
    let shipping: ProductShippingDto
    let orderBackend: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, seller, price, condition, permalink, thumbnail, attributes, installments, shipping
        case thumbnailId = "thumbnail_id"
        case originalPrice = "original_price"
        case officialStoreName = "official_store_name"
        case orderBackend = "order_backend"
    }

    func toDomain() -> ProductDomainModel {
        ProductAdapter().adapt(apiResponse: self)
    }
}
