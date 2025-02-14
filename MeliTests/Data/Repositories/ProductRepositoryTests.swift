//
//  ProductRepositoryTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class ProductRepositoryTests {
    @Test func searchProduct() async throws {
        // Given
        let query = "iPhone"
        let network = NetworkMock<ProductListDto>()
        let mockResponse: ProductListDto = .init(
            paging: .init(
                total: 1,
                offset: 0,
                limit: 10
            ),
            results:[.init(id: "MCO1625519814", title: .empty, seller: .init(id: .zero, nickname: .empty), price: .zero, condition: .empty, permalink: .empty, thumbnail: .empty, thumbnailId: .empty, attributes: [.init(id: .empty, name: .empty, value: .empty)], originalPrice: .zero, installments: .init(quantity: .zero, amount: .zero, rate: .zero), officialStoreName: .empty, shipping: .init(freeShipping: true), orderBackend: .zero)]
        )
        network.mockResponse = mockResponse
        let repository: ProductRepositoryProtocol = ProductRepository(network: network)
        do {
            // When
            let response = try await repository.searchProducts(
                siteId: "MCO",
                query: query,
                limit: 10,
                offset: 0
            )
            // Then
            #expect(response.products.count == mockResponse.results.count)
            #expect(response.products.first?.id == mockResponse.results.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func searchProductWithEmptyQuery() async throws {
        // Given
        let query = ""
        let network = NetworkMock<ProductListDto>()
        let repository: ProductRepositoryProtocol = ProductRepository(network: network)
        do {
            // When
            let _ = try await repository.searchProducts(
                siteId: "MCO",
                query: query,
                limit: 10,
                offset: 0
            )
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func getProductDetail() async throws {
        // Given
        let network = NetworkMock<ProductDetailDto>()
        let mockResponse: ProductDetailDto = .init(
            attributes: [.init(id: .empty, name: "brand", value: "apple")],
            pictures: [.init(id: .empty, secureUrl: .empty)]
        )
        network.mockResponse = mockResponse
        let repository: ProductRepositoryProtocol = ProductRepository(network: network)
        do {
            // When
            let response = try await repository.getProductDetail(id: "MCO1625519814")
            // Then
            #expect(response.attributes.count == mockResponse.attributes.count)
            #expect(response.attributes.first?.name == mockResponse.attributes.first?.name)
            #expect(response.pictures?.count == mockResponse.pictures?.count)
            #expect(response.pictures?.first?.secureUrl == mockResponse.pictures?.first?.secureUrl)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func getProductDetailWithEmptyProductId() async throws {
        // Given
        let network = NetworkMock<ProductDetailDto>()
        let repository: ProductRepositoryProtocol = ProductRepository(network: network)
        do {
            // When
            let _ = try await repository.getProductDetail(id: .empty)
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func getProductDescription() async throws {
        // Given
        let network = NetworkMock<ProductDescriptionDto>()
        let mockResponse: ProductDescriptionDto = .init(plainText: "description")
        network.mockResponse = mockResponse
        let repository: ProductRepositoryProtocol = ProductRepository(network: network)
        do {
            // When
            let response = try await repository.getProductDescription(id: "MCO1625519814")
            // Then
            #expect(response.plainText == mockResponse.plainText)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func getProductDescriptionWithEmptyProductId() async throws {
        // Given
        let network = NetworkMock<ProductDescriptionDto>()
        let repository: ProductRepositoryProtocol = ProductRepository(network: network)
        do {
            // When
            let _ = try await repository.getProductDescription(id: .empty)
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
