//
//  ProductQuestionDomainModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftData

@Model
final class ProductQuestionDomainModel: Identifiable {
    var id: String {
        text
    }
    @Attribute var dateCreated: String
    @Attribute var text: String
    @Relationship var answer: ProductAnswerQuestionDomainModel?

    init(dateCreated: String, text: String, answer: ProductAnswerQuestionDomainModel?) {
        self.dateCreated = dateCreated
        self.text = text
        self.answer = answer
    }
}
