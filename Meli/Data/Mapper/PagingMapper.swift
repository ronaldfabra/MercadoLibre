//
//  PagingMapper.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class PagingMapper: MapperProtocol {
    typealias T = PagingDto
    typealias U = PagingDomainModel

    func adapt(apiResponse: PagingDto) -> PagingDomainModel {
        return PagingDomainModel(
            total: apiResponse.total,
            offset: apiResponse.offset,
            limit: apiResponse.limit
        )
    }
}
