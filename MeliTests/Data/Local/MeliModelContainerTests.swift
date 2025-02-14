//
//  MeliModelContainerTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class MeliModelContainerTests: XCTestCase {

    @MainActor
    func testFetAllFavoritesProducts() throws {
        // Given
        let dataStorage = MeliModelContainer(storeInMemoryOnly: true)
        do {
            // When
            let response = try dataStorage.getAllFavoritesProducts()
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
        let dataStorage = MeliModelContainer(storeInMemoryOnly: true)
        do {
            // When
            try dataStorage.saveProduct(product: product)
            let response = try dataStorage.getAllFavoritesProducts()
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
        let dataStorage = MeliModelContainer(storeInMemoryOnly: true)
        do {
            // When
            try dataStorage.saveProduct(product: product)
            var response = try dataStorage.getAllFavoritesProducts()
            // Then
            #expect(response.count == 1)
            #expect(response.last?.id == "MCO1625519814")

            try dataStorage.removeProduct(productId: product.id)
            response = try dataStorage.getAllFavoritesProducts()
            #expect(response.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
