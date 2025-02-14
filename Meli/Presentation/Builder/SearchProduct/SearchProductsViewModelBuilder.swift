//
//  SearchProductsViewModelBuilder.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 13/02/25.
//


struct SearchProductsViewModelBuilder {
    static func make() -> SearchProductsViewModel {
        let siteRepository = SiteRepository(network: Network.shared)
        let productRepository = ProductRepository(network: Network.shared)
        let searchProductsUseCase = SearchProductsUseCase(repository: productRepository)
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        let viewModel = SearchProductsViewModel(
            searchProductsUseCase: searchProductsUseCase,
            getSitesUseCase: getSitesUseCase
        )
        return viewModel
    }
}
