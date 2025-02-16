//
//  ProductInstallmentDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


struct ProductInstallmentDto: DTOProtocol {
    let quantity: Int
    let amount: Double
    let rate: Double
    
    func toDomain() -> ProductInstallmentDomainModel {
        ProductInstallmentMapper().adapt(apiResponse: self)
    }
}
