//
//  QuestionRepository.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


class QuestionRepository: QuestionRepositoryProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getQuestions(itemId: String, limit: Int, offset: Int) async throws -> ProductQuestionListDomainModel {
        let response = try await network.request(
            endPoint: QuestionEndpoint
                .getQuestions(itemId: itemId, limit: limit, offset: offset),
            type: ProductQuestionListDto.self
        )
        return response.toDomain()
    }
}
