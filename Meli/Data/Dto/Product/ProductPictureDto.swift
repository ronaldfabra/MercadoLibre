//
//  ProductPictureDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


struct ProductPictureDto: DTOProtocol {
    let id: String
    let secureUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case secureUrl = "secure_url"
    }

    func toDomain() -> ProductPictureDomainModel {
        ProductPictureAdapter().adapt(apiResponse: self)
    }
}
