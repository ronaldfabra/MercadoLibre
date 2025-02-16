//
//  ProductListDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


struct ProductListDto: DTOProtocol {
    let paging: PagingDto
    let results: [ProductDto]
    
    func toDomain() -> ProductListDomainModel {
        ProductListMapper().adapt(apiResponse: self)
    }
}
