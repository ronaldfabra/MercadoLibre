//
//  QuestionRepositoryMock.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Foundation

class QuestionRepositoryMock: QuestionRepositoryProtocol {

    var mockQuestionsListResponse: ProductQuestionListDomainModel = .init(
        paging: .init(total: 1, offset: 0, limit: 10),
        questions: [.init(dateCreated: .empty, text: .empty, answer: .init(dateCreated: .empty, text: .empty))]
    )

    func getQuestions(itemId: String, limit: Int, offset: Int) async throws -> ProductQuestionListDomainModel {
        if itemId.isEmpty {
            throw NetworkErrorType.invalidData
        } else {
            mockQuestionsListResponse
        }
    }
}
