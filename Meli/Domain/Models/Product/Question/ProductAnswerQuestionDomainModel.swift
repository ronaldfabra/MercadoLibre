//
//  ProductAnswerQuestionDomainModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftData

@Model
final class ProductAnswerQuestionDomainModel: Hashable {
    @Attribute var dateCreated: String
    @Attribute var text: String
    
    init(dateCreated: String, text: String) {
        self.dateCreated = dateCreated
        self.text = text
    }
}
