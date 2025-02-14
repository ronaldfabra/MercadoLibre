//
//  SiteRepository.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class SiteRepository: SiteRepositoryProtocol {
    private let network: NetworkProtocol

    init(network: NetworkProtocol) {
        self.network = network
    }

    func getSites() async throws -> [SiteDomainModel] {
        let response = try await network.request(
            endPoint: SiteEndpoint.getSites,
            type: [SiteDto].self
        )
        return response.map { $0.toDomain() }
    }
}
