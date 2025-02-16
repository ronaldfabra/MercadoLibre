//
//  ProductPictureMapper.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class ProductPictureMapper: MapperProtocol {
    typealias T = ProductPictureDto
    typealias U = ProductPictureDomainModel
    
    func adapt(apiResponse: ProductPictureDto) -> ProductPictureDomainModel {
        return ProductPictureDomainModel(id: apiResponse.id,
                                         secureUrl: apiResponse.secureUrl)
    }
}
