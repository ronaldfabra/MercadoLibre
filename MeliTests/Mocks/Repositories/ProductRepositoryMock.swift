//
//  ProductRepositoryMock.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Foundation

class ProductRepositoryMock: ProductRepositoryProtocol {

    var mockProductListResponse: ProductListDomainModel = .init(
        paging: .init(total: 10, offset: .zero, limit: .zero),
        products: [
            .init(
                id: "MCO1520085331",
                title: "Moto G34 5g 256 Gb Negro Meteorito 8 Gb Ram Motorola",
                seller: .init(id: 0, nickname: "MELI"),
                price: 1799900,
                condition: "new",
                permalink: "https://www.mercadolibre.com.ar/p/MLA12866684",
                thumbnail: "http://mla-s1-p.mlstatic.com/980849-MLA31002261498_062019-I.jpg",
                thumbnailId: "619757-MLU75370564956_042024",
                attributes: [.init(id: "BRAND", name: "Marca", value: "Motorola")],
                originalPrice: 2499000,
                installments: .init(quantity: 12, amount: 149992, rate: 0),
                officialStoreName: nil,
                shipping: .init(freeShipping: true),
                order: 0
            )
        ]
    )

    var mockProductDetailResponse: ProductDetailDomainModel = .init(
        attributes: [.init(id: .empty, name: .empty, value: .empty)],
        pictures: [.init(id: .empty, secureUrl: .empty)]
    )

    var mockProductDescriptionResponse: ProductDescriptionDomainModel = .init(
        plainText: .empty
    )

    func searchProducts(siteId: String, query: String, limit: Int, offset: Int) async throws -> ProductListDomainModel {
        if query.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockProductListResponse
        }
    }

    func getProductDetail(id: String) async throws -> ProductDetailDomainModel {
        if id.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockProductDetailResponse
        }
    }

    func getProductDescription(id: String) async throws -> ProductDescriptionDomainModel {
        if id.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockProductDescriptionResponse
        }
    }
}
