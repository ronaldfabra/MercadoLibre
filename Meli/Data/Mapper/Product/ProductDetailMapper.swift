//
//  ProductDetailMapper.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 13/02/25.
//


class ProductDetailMapper: MapperProtocol {
    typealias T = ProductDetailDto
    typealias U = ProductDetailDomainModel
    
    func adapt(apiResponse: ProductDetailDto) -> ProductDetailDomainModel {
        return ProductDetailDomainModel(
            attributes: apiResponse.attributes.map { $0.toDomain() },
            pictures: apiResponse.pictures?.map { $0.toDomain() }
        )
    }
}
