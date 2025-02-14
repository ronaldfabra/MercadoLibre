//
//  SiteRepositoryTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class SiteRepositoryTests {
    @Test func getSites() async throws {
        // Given
        let network = NetworkMock<[SiteDto]>()
        let mockResponse: [SiteDto] = [.init(defaultCurrencyId: .empty, id: "MCO", name: "Colombia")]
        network.mockResponse = mockResponse
        let repository: SiteRepositoryProtocol = SiteRepository(network: network)
        do {
            // When
            let response = try await repository.getSites()
            // Then
            #expect(response.count == mockResponse.count)
            #expect(response.first?.id == mockResponse.first?.id)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func getSitesWithEmptyResponse() async throws {
        // Given
        let network = NetworkMock<[SiteDto]>()
        let repository: SiteRepositoryProtocol = SiteRepository(network: network)
        do {
            // When
            let _ = try await repository.getSites()
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
