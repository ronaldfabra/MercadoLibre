//
//  ProductQuestionListMapper.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class ProductQuestionListMapper: MapperProtocol {
    typealias T = ProductQuestionListDto
    typealias U = ProductQuestionListDomainModel

    func adapt(apiResponse: ProductQuestionListDto) -> ProductQuestionListDomainModel {
        return ProductQuestionListDomainModel(
            paging: .init(
                total: apiResponse.total,
                offset: apiResponse.filters.offset,
                limit: apiResponse.limit
            ),
            questions: apiResponse.questions.map { $0.toDomain() }
        )
    }
}
