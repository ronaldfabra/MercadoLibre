//
//  ProductAttributeAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class ProductAttributeAdapter: AdapterProtocol {
    typealias T = ProductAttributeDto
    typealias U = ProductAttributeDomainModel
    
    func adapt(apiResponse: ProductAttributeDto) -> ProductAttributeDomainModel {
        return ProductAttributeDomainModel(
            id: apiResponse.id,
            name: apiResponse.name,
            value: apiResponse.value
        )
    }
}
