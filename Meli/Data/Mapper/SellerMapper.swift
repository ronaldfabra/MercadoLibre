//
//  SellerMapper.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class SellerMapper: MapperProtocol {
    typealias T = SellerDto
    typealias U = SellerDomainModel

    func adapt(apiResponse: SellerDto) -> SellerDomainModel {
        return SellerDomainModel(
            id: apiResponse.id,
            nickname: apiResponse.nickname
        )
    }
}
