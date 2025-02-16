//
//  ProductShippingMapper.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class ProductShippingMapper: MapperProtocol {
    typealias T = ProductShippingDto
    typealias U = ProductShippingDomainModel

    func adapt(apiResponse: ProductShippingDto) -> ProductShippingDomainModel {
        return ProductShippingDomainModel(freeShipping: apiResponse.freeShipping)
    }
}
