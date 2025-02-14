//
//  GetProductDescriptionUseCaseTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class GetProductDescriptionUseCaseTests {
    @Test func fetchData() async throws {
        // Given
        let productId = "MCO1625519814"
        let productRepository = ProductRepositoryMock()
        let getProductDescriptionUseCase = GetProductDescriptionUseCase(repository: productRepository)
        do {
            // When
            let response = try await getProductDescriptionUseCase.execute(
                productId: productId
            )
            // Then
            #expect(response.plainText == productRepository.mockProductDescriptionResponse.plainText)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func fetchDataWithProductIdEmpty() async throws {
        // Given
        let productRepository = ProductRepositoryMock()
        let getProductDescriptionUseCase = GetProductDescriptionUseCase(repository: productRepository)
        do {
            // When
            let _ = try await getProductDescriptionUseCase.execute(
                productId: .empty
            )
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
