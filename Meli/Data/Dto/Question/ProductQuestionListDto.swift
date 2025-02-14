//
// ProductQuestionListDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


struct ProductQuestionListDto: DTOProtocol {
    let total: Int
    let limit: Int
    let questions: [ProductQuestionDto]
    let filters: ProductQuestionListFilterDto

    func toDomain() -> ProductQuestionListDomainModel {
        ProductQuestionListAdapter().adapt(apiResponse: self)
    }
}
