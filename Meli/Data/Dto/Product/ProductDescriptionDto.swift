//
//  ProductDescriptionDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


struct ProductDescriptionDto: DTOProtocol {
    let plainText: String

    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }

    func toDomain() -> ProductDescriptionDomainModel {
        ProductDescriptionAdapter().adapt(apiResponse: self)
    }
}
