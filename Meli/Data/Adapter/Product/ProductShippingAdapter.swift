//
//  ProductShippingAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class ProductShippingAdapter: AdapterProtocol {
    typealias T = ProductShippingDto
    typealias U = ProductShippingDomainModel

    func adapt(apiResponse: ProductShippingDto) -> ProductShippingDomainModel {
        return ProductShippingDomainModel(freeShipping: apiResponse.freeShipping)
    }
}
