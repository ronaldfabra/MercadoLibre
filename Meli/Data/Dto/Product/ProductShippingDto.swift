//
//  ProductShippingDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


struct ProductShippingDto: DTOProtocol {
    let freeShipping: Bool
    
    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
    
    func toDomain() -> ProductShippingDomainModel {
        ProductShippingAdapter().adapt(apiResponse: self)
    }
}
