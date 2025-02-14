//
//  ProductQuestionListFilterAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class ProductQuestionListFilterAdapter: AdapterProtocol {
    typealias T = ProductQuestionListFilterDto
    typealias U = ProductQuestionListFilterDomainModel

    func adapt(apiResponse: ProductQuestionListFilterDto) -> ProductQuestionListFilterDomainModel {
        return ProductQuestionListFilterDomainModel(offset: apiResponse.offset)
    }
}
