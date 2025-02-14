//
//  GetProductQuestionsUseCaseTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class GetProductQuestionsUseCaseTests {
    @Test func fetchData() async throws {
        // Given
        let itemId = "MCO1625519814"
        let questionRepository = QuestionRepositoryMock()
        let getProductQuestionsUseCase = GetProductQuestionsUseCase(repository: questionRepository)
        do {
            // When
            let response = try await getProductQuestionsUseCase.execute(
                itemId: itemId,
                limit: 10,
                offset: 0
            )
            // Then
            #expect(response.questions.count == questionRepository.mockQuestionsListResponse.questions.count)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func fetchDataWithEmptyItemId() async throws {
        // Given
        let questionRepository = QuestionRepositoryMock()
        let getProductQuestionsUseCase = GetProductQuestionsUseCase(repository: questionRepository)
        do {
            // When
            let _ = try await getProductQuestionsUseCase.execute(
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
