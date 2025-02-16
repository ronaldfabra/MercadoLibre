//
//  ProductAttributeDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


struct ProductAttributeDto: DTOProtocol {
    let id: String
    let name: String?
    let value: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case value = "value_name"
    }
    
    func toDomain() -> ProductAttributeDomainModel {
        ProductAttributeMapper().adapt(apiResponse: self)
    }
}
