//
//  FavoritesProductsViewModelTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class FavoritesProductsViewModelTests: XCTestCase {

    func testAddFavorite() {
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
        favoriteRepository.favoriteList = []
        let getFavoritesProductsUseCase = GetFavoritesProductsUseCase(repository: favoriteRepository)
        let addFavoriteProductUseCase = AddFavoriteProductUseCase(repository: favoriteRepository)
        let deleteFavoriteProductUseCase = DeleteFavoriteProductUseCase(repository: favoriteRepository)
        let viewModel = FavoritesProductsViewModel(
            getFavoritesProductsUseCase: getFavoritesProductsUseCase,
            addFavoriteProductUseCase: addFavoriteProductUseCase,
            deleteFavoriteProductUseCase: deleteFavoriteProductUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for productDescription is updated")
        let cancellable = viewModel.$favorites.sink { favorites in
            if !favorites.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateFavorite(product: product)
        wait(for: [expectation], timeout: 1.0)
        // Then
        #expect(viewModel.favorites.count == 1)

        cancellable.cancel()
    }

    func testDeleteFavorite() {
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
        favoriteRepository.favoriteList = [product]
        let getFavoritesProductsUseCase = GetFavoritesProductsUseCase(repository: favoriteRepository)
        let addFavoriteProductUseCase = AddFavoriteProductUseCase(repository: favoriteRepository)
        let deleteFavoriteProductUseCase = DeleteFavoriteProductUseCase(repository: favoriteRepository)
        let viewModel = FavoritesProductsViewModel(
            getFavoritesProductsUseCase: getFavoritesProductsUseCase,
            addFavoriteProductUseCase: addFavoriteProductUseCase,
            deleteFavoriteProductUseCase: deleteFavoriteProductUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for productDescription is updated")
        let cancellable = viewModel.$favorites.sink { favorites in
            if favorites.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateFavorite(product: product)
        wait(for: [expectation], timeout: 1.0)
        // Then
        #expect(viewModel.favorites.isEmpty)

        cancellable.cancel()
    }
}
