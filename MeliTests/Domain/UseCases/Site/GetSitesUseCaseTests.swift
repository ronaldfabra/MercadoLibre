//
//  GetSitesUseCaseTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class GetSitesUseCaseTests {
    @Test func fetchData() async throws {
        // Given
        let siteRepository = SiteRepositoryMock()
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        do {
            // When
            let response = try await getSitesUseCase.execute()
            // Then
            #expect(response.count == siteRepository.mockSiteListResponse.count)
        } catch {
            XCTFail("unexpected error")
        }
    }

    @Test func fetchDataWithEmptyResponse() async throws {
        // Given
        let siteRepository = SiteRepositoryMock()
        siteRepository.mockSiteListResponse = []
        let getSitesUseCase = GetSitesUseCase(repository: siteRepository)
        do {
            // When
            let _ = try await getSitesUseCase.execute()
        } catch let error as NetworkErrorType {
            // Then
            #expect(error.errorDescription == NetworkErrorType.invalidData.errorDescription)
        } catch {
            XCTFail("unexpected error")
        }
    }
}
