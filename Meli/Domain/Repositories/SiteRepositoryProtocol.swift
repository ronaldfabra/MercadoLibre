//
//  SiteRepositoryProtocol.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


protocol SiteRepositoryProtocol {
    func getSites() async throws -> [SiteDomainModel]
}
