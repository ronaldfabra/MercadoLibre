//
//  DIContainer.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 13/02/25.
//


protocol DIContainerProtocol {
    func getFavoritesProductsViewModel() -> FavoritesProductsViewModel
    func getSearchProductsViewModel() -> SearchProductsViewModel
    func getProductDetailViewModel(product: ProductDomainModel) -> ProductDetailViewModel
}

class DIContainer: DIContainerProtocol {
    static var shared: DIContainerProtocol = DIContainer()

    func getFavoritesProductsViewModel() -> FavoritesProductsViewModel {
        FavoritesProductsViewModelBuilder.make()
    }

    func getSearchProductsViewModel() -> SearchProductsViewModel {
        SearchProductsViewModelBuilder.make()
    }

    func getProductDetailViewModel(product: ProductDomainModel) -> ProductDetailViewModel {
        ProductDetailViewModelBuilder.make(product: product)
    }
}
