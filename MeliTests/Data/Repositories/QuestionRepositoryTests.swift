//
//  QuestionRepositoryTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class QuestionRepositoryTests {
    @Test func getQuestions() async throws {
        // Given
        let network = NetworkMock<ProductQuestionListDto>()
        let mockResponse: ProductQuestionListDto = .init(
            total: 1,
            limit: 10,
            questions: [.init(dateCreated: .empty, text: .empty, answer: .init(dateCreated: .empty, text: .empty))],
            filters: .init(offset: 0)
        )
        network.mockResponse = mockResponse
        let repository: QuestionRepositoryProtocol = QuestionRepository(network: network)
        do {
            // When
            let response = try await repository.getQuestions(
                itemId: "MCO1625519814",
                limit: 10,
                offset: 0
            )
            // Then
            #expect(response.questions.count == mockResponse.questions.count)
            #expect(response.questions.first?.text == mockResponse.questions.first?.text)
            #expect(response.paging.offset == mockResponse.filters.offset)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func getQuestionsWithEmptyItemId() async throws {
        // Given
        let network = NetworkMock<ProductQuestionListDto>()
        let repository: QuestionRepositoryProtocol = QuestionRepository(network: network)
        do {
            // When
            let _ = try await repository.getQuestions(
                itemId: .empty,
                limit: 10,
                offset: 0
            )
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
