//
//  MeliModelContainer.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import Combine
import Foundation
import SwiftData

protocol MeliModelContainerProtocol {
    // MARK: Products
    func saveProduct(product: ProductDomainModel) throws
    func removeProduct(productId: String) throws

    // MARK: favorites
    func getAllFavoritesProducts() throws -> [ProductDomainModel]
}

actor MeliModelContainer: NSObject {

    static let shared: MeliModelContainer = MeliModelContainer()
    static let sharedForTests: MeliModelContainer = MeliModelContainer(storeInMemoryOnly: true)

    let modelContainer: ModelContainer

    init(storeInMemoryOnly: Bool = false) {
        self.modelContainer = MeliModelContainer.createContainer(storeInMemoryOnly: storeInMemoryOnly)
    }

    static func createContainer(storeInMemoryOnly: Bool = false) -> ModelContainer {
        let schema = Schema(
            [
                ProductDomainModel.self,
                SellerDomainModel.self,
                ProductAttributeDomainModel.self,
                ProductInstallmentDomainModel.self,
                ProductShippingDomainModel.self
            ]
        )
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: storeInMemoryOnly)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("unable to create the contaienr: \(error)")
        }
    }
}

// MARK: MeliModelContainerProtocol
extension MeliModelContainer: @preconcurrency MeliModelContainerProtocol {
    @MainActor
    func saveProduct(product: ProductDomainModel) throws {
        do {
            product.savedDate = Date()
            modelContainer.mainContext.insert(product)
            try modelContainer.mainContext.save()
        } catch {
            throw error
        }
    }

    @MainActor
    func removeProduct(productId: String) throws {
        Task {
            do {
                guard let product = try await getProductById(productId) else { return }
                modelContainer.mainContext.delete(product)
                try modelContainer.mainContext.save()
            } catch {
                throw error
            }
        }
    }

    @MainActor
    private func getProductById(_ id: String) async throws -> ProductDomainModel? {
        do {
            let productPredicate = #Predicate<ProductDomainModel> {
                $0.id == id
            }
            let descriptor = FetchDescriptor<ProductDomainModel>(predicate: productPredicate)
            let products = try modelContainer.mainContext.fetch(descriptor)
            return products.first
        } catch {
            throw error
        }
    }

    @MainActor
    func getAllFavoritesProducts() throws -> [ProductDomainModel] {
        do {
            let descriptor = FetchDescriptor<ProductDomainModel>()
            let products = try modelContainer.mainContext.fetch(descriptor)
            return products
        } catch {
            throw error
        }
    }
}
