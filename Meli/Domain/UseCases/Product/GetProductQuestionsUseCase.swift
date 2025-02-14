//
//  GetProductQuestionsUseCase.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


protocol GetProductQuestionsUseCaseProtocol {
    func execute(itemId: String, limit: Int, offset: Int) async throws -> ProductQuestionListDomainModel
}

class GetProductQuestionsUseCase: GetProductQuestionsUseCaseProtocol {
    private let repository: QuestionRepositoryProtocol
    
    init(repository: QuestionRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(itemId: String, limit: Int, offset: Int) async throws -> ProductQuestionListDomainModel {
        try await repository.getQuestions(itemId: itemId, limit: limit, offset: offset)
    }
}
