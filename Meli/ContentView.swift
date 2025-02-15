//
//  ContentView.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @StateObject var favoritesProductsViewModel: FavoritesProductsViewModel

    init(dependencyContainer: DIContainerProtocol) {
        self._favoritesProductsViewModel = StateObject(
            wrappedValue: dependencyContainer.getFavoritesProductsViewModel()
        )
    }

    var body: some View {
        tabView
            .accessibilityIdentifier("tabView")
            .environmentObject(favoritesProductsViewModel)
    }

    private var tabView: some View {
        TabView {
            SearchProductsView(dependencyContainer: DIContainer.shared)
                .tabItem {
                    Label(
                        MeliConstants.Strings.searchProduct,
                        systemImage: MeliConstants.Icons.search
                    )
                }
                .accessibilityIdentifier("searchProductsView")

            FavoritesProductsView()
                .tabItem {
                    Label(
                        MeliConstants.Strings.favorites,
                        systemImage: MeliConstants.Icons.notFavorite
                    )
                }
                .accessibilityIdentifier("favoritesProductsView")
        }
    }
}

#Preview {
    ContentView(dependencyContainer: DIContainer.shared)
}
