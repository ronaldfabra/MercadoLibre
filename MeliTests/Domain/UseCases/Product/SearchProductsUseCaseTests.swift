//
//  SearchProductsUseCaseTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class SearchProductsUseCaseTests {
    @Test func fetchData() async throws {
        // Given
        let query = "iPhone"
        let productRepository = ProductRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        do {
            // When
            let response = try await searchProductsUseCase.execute(
                siteId: "MCO",
                query: query,
                limit: 10,
                offset: 0
            )
            // Then
            #expect(response.products.count == productRepository.mockProductListResponse.products.count)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func fetchDataWithInvalidQuery() async throws {
        // Given
        let productRepository = ProductRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        do {
            // When
            let _ = try await searchProductsUseCase.execute(
                siteId: "MCO",
                query: .empty,
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
}
