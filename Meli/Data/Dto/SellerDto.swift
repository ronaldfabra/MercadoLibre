//
//  SellerDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


struct SellerDto: DTOProtocol {
    let id: Int
    let nickname: String?

    func toDomain() -> SellerDomainModel {
        SellerAdapter().adapt(apiResponse: self)
    }
}
