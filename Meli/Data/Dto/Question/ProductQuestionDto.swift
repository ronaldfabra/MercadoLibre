//
//  ProductQuestionDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


struct ProductQuestionDto: DTOProtocol {
    let dateCreated: String
    let text: String
    let answer: ProductAnswerQuestionDto?

    enum CodingKeys: String, CodingKey {
        case text, answer
        case dateCreated = "date_created"
    }

    func toDomain() -> ProductQuestionDomainModel {
        ProductQuestionAdapter().adapt(apiResponse: self)
    }
}
