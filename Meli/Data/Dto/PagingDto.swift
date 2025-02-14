//
//  PagingDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


struct PagingDto: DTOProtocol {
    let total: Int
    let offset: Int
    let limit: Int

    func toDomain() -> PagingDomainModel {
        PagingAdapter().adapt(apiResponse: self)
    }
}
