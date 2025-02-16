//
//  ProductDetailDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 13/02/25.
//


struct ProductDetailDto: DTOProtocol {
    let attributes: [ProductAttributeDto]
    let pictures: [ProductPictureDto]?

    func toDomain() -> ProductDetailDomainModel {
        ProductDetailMapper().adapt(apiResponse: self)
    }
}
