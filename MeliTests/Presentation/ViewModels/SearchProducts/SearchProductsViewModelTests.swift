//
//  SearchProductsViewModelTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class SearchProductsViewModelTests: XCTestCase {

    func testUpdateQuery() {
        // Given
        let query = "iPhone"
        let productRepository = ProductRepositoryMock()
        let siteRepository = SiteRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for products is updated")
        let cancellable = viewModel.$products.sink { products in
            if !products.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateQuery(query: query)
        wait(for: [expectation], timeout: 5.0)
        // Then
        #expect(viewModel.products.count == productRepository.mockProductListResponse.products.count)
        #expect(viewModel.products.first?.id == productRepository.mockProductListResponse.products.first?.id)

        cancellable.cancel()
    }

    func testUpdateQueryWithEmptyValue() {
        // Given
        let query = ""
        let productRepository = ProductRepositoryMock()
        let siteRepository = SiteRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        // When
        viewModel.updateQuery(query: query)
        // Then
        #expect(viewModel.products.isEmpty)
    }

    func testLoadMoreProducts() {
        // Given
        let query = "iPhone"
        let productRepository = ProductRepositoryMock()
        let siteRepository = SiteRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for products is updated")
        let cancellable = viewModel.$products.sink { products in
            if !products.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateQuery(query: query)
        viewModel.loadMoreProducts()
        wait(for: [expectation], timeout: 5.0)
        // Then
        #expect(viewModel.products.count == productRepository.mockProductListResponse.products.count)
        #expect(viewModel.products.first?.id == productRepository.mockProductListResponse.products.first?.id)

        cancellable.cancel()
    }

    func testLoadMoreProductsWithEmptyValue() {
        // Given
        let query = ""
        let productRepository = ProductRepositoryMock()
        let siteRepository = SiteRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        // When
        viewModel.updateQuery(query: query)
        viewModel.loadMoreProducts()
        // Then
        #expect(viewModel.products.isEmpty)
    }

    func testChangeListAdapterByList() {
        // Given
        let productRepository = ProductRepositoryMock()
        let siteRepository = SiteRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        let rowListStrategy = RowListStrategy()
        // When
        viewModel.changeListAdapter(to: rowListStrategy)
        // Then
        #expect(viewModel.productListAdapter is RowListViewAdapter)
    }

    func testChangeListAdapterByGrid() {
        // Given
        let productRepository = ProductRepositoryMock()
        let siteRepository = SiteRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        let gridStrategy = GridListStrategy()
        // When
        viewModel.changeListAdapter(to: gridStrategy)
        // Then
        #expect(viewModel.productListAdapter is GridListViewAdapter)
    }

    func testTryAgainSites() {
        // Given
        let productRepository = ProductRepositoryMock()
        let siteRepository = SiteRepositoryMock()
        siteRepository.mockSiteListResponse = []
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for products is updated")
        let cancellable = viewModel.$sitesForMenu.sink { products in
            if !products.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.tryAgain()
        siteRepository.mockSiteListResponse = [.init(defaultCurrencyId: .empty, id: "MCO", name: "Colombia")]
        wait(for: [expectation], timeout: 1.0)
        // Then
        #expect(viewModel.sitesForMenu.count == siteRepository.mockSiteListResponse.count)
        #expect(viewModel.sitesForMenu.first == siteRepository.mockSiteListResponse.first?.name)
        cancellable.cancel()
    }

    func testTryAgain() {
        // Given
        let query = "iPhone"
        let productRepository = ProductRepositoryMock()
        let siteRepository = SiteRepositoryMock()
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        let expectation = XCTestExpectation(description: "Wait for sites is updated")
        let cancellable = viewModel.$products.sink { sites in
            if !sites.isEmpty {
                expectation.fulfill()
            }
        }
        // When
        viewModel.updateQuery(query: query)
        viewModel.tryAgain()
        wait(for: [expectation], timeout: 5.0)
        // Then
        #expect(viewModel.products.count == productRepository.mockProductListResponse.products.count)
        #expect(viewModel.products.first?.id == productRepository.mockProductListResponse.products.first?.id)
        cancellable.cancel()
    }
}
