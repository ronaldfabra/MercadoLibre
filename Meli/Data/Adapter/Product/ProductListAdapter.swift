//
//  ProductListAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class ProductListAdapter: AdapterProtocol {
    typealias T = ProductListDto
    typealias U = ProductListDomainModel
    
    func adapt(apiResponse: ProductListDto) -> ProductListDomainModel {
        return ProductListDomainModel(
            paging: apiResponse.paging.toDomain(),
            products: apiResponse.results.map { $0.toDomain()}
        )
    }
}
