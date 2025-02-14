//
//  SearchProductsViewModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import Combine
import Foundation
import SwiftUI

class SearchProductsViewModel: ObservableObject {
    @Published var paging: PagingDomainModel?
    @Published var products: [ProductDomainModel] = []
    @Published var showSkeleton: Bool = false
    @Published var isLoading: Bool = false
    @Published var error: NetworkErrorType = .none
    @Published var productListAdapter: ProductListViewAdapter = RowListViewAdapter(strategy: RowListStrategy())
    @Published var sitesForMenu: [String] = []
    private var sites: [SiteDomainModel] = []
    @Published var selectedSite: String? = nil
    private var cancellables = Set<AnyCancellable>()
    private var querySubject = CurrentValueSubject<String, Never>(.empty)
    private let itemLimit: Int = 10
    
    private let searchProductsUseCase: SearchProductsUseCaseProtocol
    private let getSitesUseCase: GetSitesUseCaseProtocol
    
    var isGridList: Bool {
        productListAdapter is GridListViewAdapter
    }
    
    init(searchProductsUseCase: SearchProductsUseCaseProtocol, getSitesUseCase: GetSitesUseCaseProtocol) {
        self.searchProductsUseCase = searchProductsUseCase
        self.getSitesUseCase = getSitesUseCase
        querySubject
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self else { return }
                Task {
                    await self.searchProducts(query: query, isNewQuery: true)
                }
            }
            .store(in: &cancellables)
        getSites()
    }
    
    private func getSites() {
        Task {
            do {
                let response = try await getSitesUseCase.execute()
                await self.processSitesResponse(response)
            } catch {
                await self.processError(error)
            }
        }
    }
    
    @MainActor
    private func processSitesResponse(_ response: [SiteDomainModel]) {
        self.sites = response
        self.sitesForMenu = response.map(\.name)
        self.selectedSite = sitesForMenu.first
    }
    
    @MainActor
    private func searchProducts(query: String, isNewQuery: Bool) {
        if query.isEmpty {
            self.products = []
        } else {
            Task {
                //#if DEBUG
                //self.products = [.init()]
                //#else
                if isNewQuery {
                    self.resetData()
                }
                self.showSkeleton = products.isEmpty
                self.isLoading = true
                do {
                    let response = try await searchProductsUseCase.execute(
                        siteId: getCurrentSiteId(),
                        query: query,
                        limit: itemLimit,
                        offset: getNextOffset()
                    )
                    self.paging = response.paging
                    if response.paging.offset == .zero {
                        products = response.products.sorted { $0.order < $1.order }
                    } else {
                        products.append(contentsOf: response.products.sorted { $0.order < $1.order })
                    }
                    self.isLoading = false
                    self.showSkeleton = false
                } catch {
                    self.processError(error)
                }
                //#endif
            }
        }
    }
    
    @MainActor
    private func processError(_ error: Error) {
        if products.isEmpty {
            if let error = error as? NetworkErrorType {
                self.error = error
            } else {
                self.error = .unkown(error)
            }
        }
        self.isLoading = false
        self.showSkeleton = false
    }
    
    
    @MainActor
    private func resetData() {
        self.error = .none
        self.products = []
        self.paging = nil
    }
    
    private func getCurrentSiteId() -> String {
        let currentSiteId = sites.first(where: { $0.name == selectedSite ?? MeliConstants.Strings.colombiaSiteId })?.id
        return currentSiteId ?? MeliConstants.Strings.colombiaSiteId
    }
    
    private func getNextOffset() -> Int {
        if paging?.offset ?? .zero + itemLimit >= paging?.total ?? .zero {
            return (paging?.offset ?? .zero)
        } else {
            return (paging?.offset ?? .zero) + itemLimit
        }
    }
}

extension SearchProductsViewModel {
    func updateQuery(query: String) {
        querySubject.send(query)
    }
    
    func loadMoreProducts() async {
        guard !isLoading else { return }
        await self.searchProducts(query: querySubject.value, isNewQuery: false)
    }
    
    func onChangedSite() async {
        guard !isLoading else { return }
        await self.searchProducts(query: querySubject.value, isNewQuery: true)
    }
    
    func changeListAdapter(to strategy: ProductListViewStrategy) {
        switch strategy {
        case is GridListStrategy:
            productListAdapter = GridListViewAdapter(strategy: GridListStrategy())
        case is RowListStrategy:
            productListAdapter = RowListViewAdapter(strategy: RowListStrategy())
        default:
            break
        }
    }
    
    func setCurrentCountry(country: String) {
        if let site = sitesForMenu.first(where: { $0.lowercased() == country.lowercased()}) {
            selectedSite = site
        }
    }
    
    func tryAgain() {
        Task {
            await resetData()
            if sites.isEmpty {
                getSites()
            } else  {
                await onChangedSite()
            }
        }
    }
}
