//
//  FavoritesProductsView.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

struct FavoritesProductsView: View {

    typealias Dimens = MeliConstants.Dimens
    typealias Strings = MeliConstants.Strings

    @State private var selectedItem: ProductDomainModel?
    @EnvironmentObject var viewModel: FavoritesProductsViewModel
    @EnvironmentObject var toastManager: ToastManager
    @State private var selectedFavoriteId: Int? = nil

    var body: some View {
        NavigationStack {
            bodyView
                .navigationDestination(
                    for: ProductDomainModel.self
                ) { product in
                    ProductDetailView(product: product, dependencyContainer: DIContainer.shared)
                }
                .onChange(of: viewModel.error) { _, error in
                    if error != .none {
                        toastManager.showToast(message: error.errorDescription)
                    } else {
                        toastManager.hideToast()
                    }
                }
                .navigationBar(.yellow)
        }
    }
}

// MARK: bodyView
extension FavoritesProductsView {
    private var bodyView: some View {
        VStack {
            contentView
                .navigationBarTitle(Strings.favorites,
                                    displayMode: .inline)
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}

// MARK: contentView
extension FavoritesProductsView {
    private var contentView: some View {
        VStack(spacing: .zero) {
            if viewModel.favorites.isEmpty {
                emptyState
            } else {
                listView
            }
        }
    }
}

// MARK: listView
extension FavoritesProductsView {
    private var listView: some View {
        List {
            ForEach(viewModel.favorites, id: \.id) { product in
                NavigationLink(value: product) {
                    ProductCell(product: product,
                                isFavorite: viewModel
                        .isFavorite(productId: product.id)) {
                            viewModel.updateFavorite(product: product)
                        }
                }
            }
        }
    }
}

// MARK: emptyState
extension FavoritesProductsView {
    private var emptyState: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: Dimens.spacing20) {
                VStack(alignment: .center, spacing: Dimens.spacing10) {
                    Text(Strings.EmptyState.Favorites.title)
                        .font(
                            .system(
                                size: MeliConstants.Values.value30,
                                weight: .bold
                            )
                        )
                        .accessibilityIdentifier(Strings.EmptyState.Favorites.title)
                    Text(Strings.EmptyState.Favorites.message)
                        .font(.system(size: MeliConstants.Values.value20, weight: .light))
                        .accessibilityIdentifier(Strings.EmptyState.Favorites.message)
                }
                HStack(spacing: .zero) {
                    Text(Strings.EmptyState.Favorites.addFavoriteHelper) +
                    Text(Image(systemName: MeliConstants.Icons.notFavorite)) +
                    Text(Strings.EmptyState.Favorites.button)
                }
                .font(
                    .system(size: MeliConstants.Values.value14, weight: .light)
                )
            }
            Spacer()
        }
        .padding(.horizontal, Dimens.spacing30)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    FavoritesProductsView()
        .environmentObject(FavoritesProductsViewModelBuilder.make())
        .environmentObject(ToastManager())
}
