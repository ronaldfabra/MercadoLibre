//
//  QuestionRepositoryProtocol.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


protocol QuestionRepositoryProtocol {
    func getQuestions(itemId: String, limit: Int, offset: Int) async throws -> ProductQuestionListDomainModel
}
