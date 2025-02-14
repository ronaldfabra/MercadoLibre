//
//  FavoritesProductsViewModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import CoreData
import Foundation

class FavoritesProductsViewModel: ObservableObject {
    @Published var favorites: [ProductDomainModel] = []
    @Published var error: NetworkErrorType = .none

    private let getFavoritesProductsUseCase: GetFavoritesProductsUseCaseProtocol
    private let addFavoriteProductUseCase: AddFavoriteProductUseCaseProtocol
    private let deleteFavoriteProductUseCase: DeleteFavoriteProductUseCaseProtocol

    init(getFavoritesProductsUseCase: GetFavoritesProductsUseCaseProtocol,
         addFavoriteProductUseCase: AddFavoriteProductUseCaseProtocol,
         deleteFavoriteProductUseCase: DeleteFavoriteProductUseCaseProtocol) {
        self.getFavoritesProductsUseCase = getFavoritesProductsUseCase
        self.addFavoriteProductUseCase = addFavoriteProductUseCase
        self.deleteFavoriteProductUseCase = deleteFavoriteProductUseCase
        loadFavorites()
    }

    func loadFavorites() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.error = .none
            do {
                self.favorites = try self.getFavoritesProductsUseCase.execute().sorted { $0.order < $1.order }
            } catch {
                self.error = .generalError
            }
        }
    }

    private func addToFavorite(product: ProductDomainModel) async {
        do {
            try addFavoriteProductUseCase.execute(product: product)
        } catch {
            self.error = .generalError
        }
    }

    private func removeFromFavorite(productId: String) async {
        do {
            try deleteFavoriteProductUseCase.execute(productId: productId)
        } catch {
            self.error = .generalError
        }
    }
}

extension FavoritesProductsViewModel {
    func updateFavorite(product: ProductDomainModel) {
        Task {
            if isFavorite(productId: product.id) {
                await removeFromFavorite(productId: product.id)
            } else {
                await addToFavorite(product: product)
            }
            loadFavorites()
        }
    }

    func isFavorite(productId: String) -> Bool {
        return favorites.contains(where: { $0.id == productId })
    }
}
