//
//  SiteRepositoryMock.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Foundation

class SiteRepositoryMock: SiteRepositoryProtocol {

    var mockSiteListResponse: [SiteDomainModel] = [.init(defaultCurrencyId: .empty, id: "MCO", name: "Colombia")]

    func getSites() async throws -> [SiteDomainModel] {
        if mockSiteListResponse.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockSiteListResponse
        }
    }
}
