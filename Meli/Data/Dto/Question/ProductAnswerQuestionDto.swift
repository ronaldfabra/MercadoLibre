//
//  ProductAnswerQuestionDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


struct ProductAnswerQuestionDto: DTOProtocol {
    let dateCreated: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case text
        case dateCreated = "date_created"
    }

    func toDomain() -> ProductAnswerQuestionDomainModel {
        ProductAnswerQuestionMapper().adapt(apiResponse: self)
    }
}
