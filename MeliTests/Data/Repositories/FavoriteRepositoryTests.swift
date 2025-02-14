//
//  FavoriteRepositoryTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class FavoriteRepositoryTests: XCTestCase {

    @MainActor
    func testFetAllFavoritesProducts() throws {
        // Given
        let database = MeliModelContainer(storeInMemoryOnly: true)
        let repository: FavoriteRepositoryProtocol = FavoriteRepository(
            database: database
        )
        do {
            // When
            let response = try repository.getAllFavoritesProducts()
            // Then
            #expect(response.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
        // Then
    }

    @MainActor
    func testSaveProduct() {
        // Given
        let product = ProductDomainModel(
            id: "MCO1625519814",
            title: .empty,
            seller: nil,
            price: .zero,
            condition: .empty,
            permalink: .empty,
            thumbnail: .empty,
            thumbnailId: .empty,
            attributes: [.init(id: .empty, name: .empty, value: .empty)],
            originalPrice: .zero,
            installments: nil,
            officialStoreName: .empty,
            shipping: .init(freeShipping: true),
            order: .zero
        )
        let database = MeliModelContainer(storeInMemoryOnly: true)
        let repository: FavoriteRepositoryProtocol = FavoriteRepository(
            database: database
        )
        do {
            // When
            try repository.saveFavoriteProduct(product: product)
            let response = try repository.getAllFavoritesProducts()
            // Then
            #expect(response.count == 1)
            #expect(response.last?.id == "MCO1625519814")
        } catch {
            XCTFail("unexpected error")
        }
    }

    @MainActor
    func testRemoveProduct() {
        // Given
        let product = ProductDomainModel(
            id: "MCO1625519814",
            title: .empty,
            seller: nil,
            price: .zero,
            condition: .empty,
            permalink: .empty,
            thumbnail: .empty,
            thumbnailId: .empty,
            attributes: [.init(id: .empty, name: .empty, value: .empty)],
            originalPrice: .zero,
            installments: nil,
            officialStoreName: .empty,
            shipping: .init(freeShipping: true),
            order: .zero
        )
        let database = MeliModelContainer(storeInMemoryOnly: true)
        let repository: FavoriteRepositoryProtocol = FavoriteRepository(
            database: database
        )
        do {
            // When
            try repository.saveFavoriteProduct(product: product)
            var response = try repository.getAllFavoritesProducts()
            // Then
            #expect(response.count == 1)
            #expect(response.last?.id == "MCO1625519814")

            try repository.removeProduct(productId: product.id)
            response = try repository.getAllFavoritesProducts()
            #expect(response.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
