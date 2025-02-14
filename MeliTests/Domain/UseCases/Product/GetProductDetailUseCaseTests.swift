//
//  GetProductDetailUseCaseTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class GetProductDetailUseCaseTests {
    @Test func fetchData() async throws {
        // Given
        let productId = "MCO1625519814"
        let productRepository = ProductRepositoryMock()
        let getProductDetailUseCase = GetProductDetailUseCase(repository: productRepository)
        do {
            // When
            let response = try await getProductDetailUseCase.execute(
                productId: productId
            )
            // Then
            #expect(response.attributes.count == productRepository.mockProductDetailResponse.attributes.count)
            #expect(response.pictures?.count == productRepository.mockProductDetailResponse.pictures?.count)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func fetchDataWithProductIdEmpty() async throws {
        // Given
        let productRepository = ProductRepositoryMock()
        let getProductDetailUseCase = GetProductDetailUseCase(repository: productRepository)
        do {
            // When
            let _ = try await getProductDetailUseCase.execute(
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
