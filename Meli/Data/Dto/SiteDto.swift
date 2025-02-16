//
//  SiteDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

struct SiteDto: DTOProtocol {
    let defaultCurrencyId: String
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case defaultCurrencyId = "default_currency_id"
    }

    func toDomain() -> SiteDomainModel {
        SiteMapper().adapt(apiResponse: self)
    }
}
