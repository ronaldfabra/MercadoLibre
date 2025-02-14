//
//  SiteAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class SiteAdapter: AdapterProtocol {
    typealias T = SiteDto
    typealias U = SiteDomainModel

    func adapt(apiResponse: SiteDto) -> SiteDomainModel {
        return SiteDomainModel(
            defaultCurrencyId: apiResponse.defaultCurrencyId,
            id: apiResponse.id,
            name: apiResponse.name
        )
    }
}
