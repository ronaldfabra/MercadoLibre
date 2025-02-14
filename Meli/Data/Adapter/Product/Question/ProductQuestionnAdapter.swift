//
//  ProductQuestionAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class ProductQuestionAdapter: AdapterProtocol {
    typealias T = ProductQuestionDto
    typealias U = ProductQuestionDomainModel

    func adapt(apiResponse: ProductQuestionDto) -> ProductQuestionDomainModel {
        return ProductQuestionDomainModel(
            dateCreated: apiResponse.dateCreated,
            text: apiResponse.text,
            answer: apiResponse.answer?.toDomain()
        )
    }
}
