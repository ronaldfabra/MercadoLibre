//
//  FavoritesProductsViewModelBuilder.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 13/02/25.
//


struct FavoritesProductsViewModelBuilder {
    static func make() -> FavoritesProductsViewModel {
        let favoriteRepository = FavoriteRepository(database: MeliModelContainer.shared)
        let getFavoritesProductsUseCase = GetFavoritesProductsUseCase(repository: favoriteRepository)
        let addFavoriteProductUseCase = AddFavoriteProductUseCase(repository: favoriteRepository)
        let deleteFavoriteProductUseCase = DeleteFavoriteProductUseCase(repository: favoriteRepository)
        let viewModel = FavoritesProductsViewModel(
            getFavoritesProductsUseCase: getFavoritesProductsUseCase,
            addFavoriteProductUseCase: addFavoriteProductUseCase,
            deleteFavoriteProductUseCase: deleteFavoriteProductUseCase
        )
        return viewModel
    }
}
