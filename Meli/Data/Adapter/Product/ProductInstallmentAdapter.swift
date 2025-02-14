//
//  ProductInstallmentAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


class ProductInstallmentAdapter: AdapterProtocol {
    typealias T = ProductInstallmentDto
    typealias U = ProductInstallmentDomainModel
    
    func adapt(apiResponse: ProductInstallmentDto) -> ProductInstallmentDomainModel {
        return ProductInstallmentDomainModel(
            quantity: apiResponse.quantity,
            amount: apiResponse.amount,
            rate: apiResponse.rate
        )
    }
}
