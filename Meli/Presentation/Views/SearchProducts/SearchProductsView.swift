//
//  SearchProductsView.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

struct SearchProductsView: View {

    typealias Dimens = MeliConstants.Dimens

    @State private var query: String = .empty
    @StateObject var viewModel: SearchProductsViewModel
    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var favoritesProductsViewModel: FavoritesProductsViewModel
    @EnvironmentObject var toastManager: ToastManager

    init(dependencyContainer: DIContainerProtocol) {
        self._viewModel = StateObject(
            wrappedValue: dependencyContainer.getSearchProductsViewModel()
        )
    }

    init() {
        self._viewModel = StateObject(
            wrappedValue: SearchProductsViewModelBuilder.make()
        )
    }

    var body: some View {
        NavigationStack {
            contentView
                .navigationBarTitle(MeliConstants.Strings.searchProduct,
                                    displayMode: .inline
                )
                .navigationDestination(
                    for: ProductDomainModel.self
                ) { product in
                    ProductDetailView(product: product, dependencyContainer: DIContainer.shared)
                }
                .padding(.horizontal, Dimens.spacing10)
        }
        .onAppear {
            locationManager.requestLocationPermission()
        }
        .onChange(of: locationManager.country ?? .empty) { _, newValue in
            viewModel.setCurrentCountry(country: newValue)
        }
        .onChange(of: viewModel.error) { _, error in
            if error != .none {
                toastManager.showToast(message: error.errorDescription,
                                       fixed: true) {
                    viewModel.tryAgain()
                }
            } else {
                toastManager.hideToast()
            }
        }
    }
}

// MARK: contentView
extension SearchProductsView {
    private var contentView: some View {
        VStack(alignment: .leading, spacing: Dimens.spacing10) {
            textfield
            Divider()
            buttons
            Divider()
            if viewModel.showSkeleton {
                skeletonView
            } else {
                if viewModel.products.isEmpty {
                    emptyView
                } else {
                    viewModel.productListAdapter
                        .getListView(
                            for: viewModel.products,
                            favoritesProductsViewModel: favoritesProductsViewModel,
                            onLastItemVisible: {
                                Task {
                                    await viewModel.loadMoreProducts()
                                }
                            }
                        )
                }
            }
        }
    }

    private var textfield: some View {
        TextField(MeliConstants.Strings.searchProduct,
                  text: $query)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .accessibilityIdentifier("searchProductTextfield")
        .onChange(of: query) { _, newValue in
            viewModel.updateQuery(query: newValue)
        }
    }

    private var buttons: some View {
        HStack {
            if !viewModel.sitesForMenu.isEmpty {
                SiteListButton(options: viewModel.sitesForMenu,
                               selectedOption: $viewModel.selectedSite)
            }
            LayoutListButton(isGrid: viewModel.isGridList) {
                if viewModel.isGridList {
                    viewModel.changeListAdapter(to: RowListStrategy())
                } else {
                    viewModel.changeListAdapter(to: GridListStrategy())
                }
            }
            .onChange(of: viewModel.selectedSite) { _, _ in
                Task {
                    await viewModel.onChangedSite()
                }
            }
        }
    }
}

// MARK: listView
extension SearchProductsView {
    private var emptyView: some View {
        VStack {
            Spacer()
            Text(MeliConstants.Strings.EmptyState.Search.title)
                .font(.system(size: MeliConstants.Values.value20, weight: .light))
                .accessibilityIdentifier(MeliConstants.Strings.EmptyState.Search.title)
            Spacer()
        }
        .padding(Dimens.spacing50)
        .multilineTextAlignment(.center)
    }
}

// MARK: skeletonView
extension SearchProductsView {
    var skeletonView: some View {
        VStack(spacing: Dimens.spacing20) {
            SkeletonView().frame(height: Dimens.productImageRowSize)
            SkeletonView().frame(height: Dimens.productImageRowSize)
            SkeletonView().frame(height: Dimens.productImageRowSize)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SearchProductsView(dependencyContainer: DIContainer.shared)
        .environmentObject(FavoritesProductsViewModelBuilder.make())
        .environmentObject(ToastManager())
}
