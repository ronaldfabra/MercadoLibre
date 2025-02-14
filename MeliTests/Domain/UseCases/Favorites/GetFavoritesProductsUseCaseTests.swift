//
//  GetFavoritesProductsUseCaseTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class GetFavoritesProductsUseCaseTests {
    @Test func getAllFavoritesProducts() async throws {
        // Given
        let favoriteRepository = FavoriteRepositoryMock()
        let getFavoritesProductsUseCase = GetFavoritesProductsUseCase(repository: favoriteRepository)
        do {
            // When
            let response = try getFavoritesProductsUseCase.execute()
            // Then
            #expect(response.isEmpty)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
