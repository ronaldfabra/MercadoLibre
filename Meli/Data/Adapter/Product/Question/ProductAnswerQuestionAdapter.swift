//
//  ProductAnswerQuestionAdapter.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class ProductAnswerQuestionAdapter: AdapterProtocol {
    typealias T = ProductAnswerQuestionDto
    typealias U = ProductAnswerQuestionDomainModel

    func adapt(apiResponse: ProductAnswerQuestionDto) -> ProductAnswerQuestionDomainModel {
        return ProductAnswerQuestionDomainModel(
            dateCreated: apiResponse.dateCreated,
            text: apiResponse.text
        )
    }
}
