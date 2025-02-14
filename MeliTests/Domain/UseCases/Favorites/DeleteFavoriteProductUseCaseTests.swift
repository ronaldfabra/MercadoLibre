//
//  DeleteFavoriteProductUseCaseTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class DeleteFavoriteProductUseCaseTests {
    @Test func removeProduct() async throws {
        // Given
        let product: ProductDomainModel = .init(
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
        let favoriteRepository = FavoriteRepositoryMock()
        let addFavoriteProductUseCase = AddFavoriteProductUseCase(repository: favoriteRepository)
        let deleteFavoriteProductUseCase = DeleteFavoriteProductUseCase(repository: favoriteRepository)
        do {
            // When
            try addFavoriteProductUseCase.execute(product: product)
            // Then
            #expect(favoriteRepository.favoriteList.count == 1)
            #expect(favoriteRepository.favoriteList.last?.id == product.id)

            try deleteFavoriteProductUseCase.execute(productId: product.id)
            #expect(favoriteRepository.favoriteList.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func removeProducttWithInvalidProductId() async throws {
        // Given
        let product: ProductDomainModel = .init(
            id: .empty,
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
        let favoriteRepository = FavoriteRepositoryMock()
        let addFavoriteProductUseCase = AddFavoriteProductUseCase(repository: favoriteRepository)
        let deleteFavoriteProductUseCase = DeleteFavoriteProductUseCase(repository: favoriteRepository)
        do {
            // When
            try addFavoriteProductUseCase.execute(product: product)
            // Then
            #expect(favoriteRepository.favoriteList.count == 1)
            #expect(favoriteRepository.favoriteList.last?.id == product.id)

            try deleteFavoriteProductUseCase.execute(productId: .empty)
            #expect(!favoriteRepository.favoriteList.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
