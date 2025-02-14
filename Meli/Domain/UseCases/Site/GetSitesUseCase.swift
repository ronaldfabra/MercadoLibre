//
//  GetSitesUseCase.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


protocol GetSitesUseCaseProtocol {
    func execute() async throws -> [SiteDomainModel]
}

class GetSitesUseCase: GetSitesUseCaseProtocol {
    private let repository: SiteRepositoryProtocol

    init(repository: SiteRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [SiteDomainModel] {
        try await repository.getSites()
    }
}
