//
//  ProductDescriptionMapper.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class ProductDescriptionMapper: MapperProtocol {
    typealias T = ProductDescriptionDto
    typealias U = ProductDescriptionDomainModel
    
    func adapt(apiResponse: ProductDescriptionDto) -> ProductDescriptionDomainModel {
        return ProductDescriptionDomainModel(plainText: apiResponse.plainText)
    }
}
