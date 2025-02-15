//
//  MeliUtilsTests.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//

@testable import Meli
import Testing
import XCTest

final class MeliUtilsTests {
    @Test func getImageUrlFromThumbnailId() {
        // Given
        let thumbnailId = "619757-MLU75370564956_042024"
        let thumbnail = "http://mla-s1-p.mlstatic.com/980849-MLA31002261498_062019-I.jpg"
        let expectedUrlStr = String(
            format: "%@%@%@",
            MeliConstants.MeliURL.imageBaseURL,
            thumbnailId,
            MeliConstants.MeliURL.thumnailImageUrlExtension
        )
        // When
        let url = MeliUtils.getImageUrl(thumbnailId: thumbnailId,
                                        thumbnail: thumbnail,
                                        urlExtension: MeliConstants.MeliURL.thumnailImageUrlExtension)
        // Then
        #expect(url?.absoluteString == expectedUrlStr)
    }

    @Test func getImageUrlFromThumbnail() {
        // Given
        let thumbnail = "http://mla-s1-p.mlstatic.com/980849-MLA31002261498_062019-I.jpg"
        // When
        let url = MeliUtils.getImageUrl(thumbnailId: nil,
                                        thumbnail: thumbnail,
                                        urlExtension: MeliConstants.MeliURL.thumnailImageUrlExtension)
        // Then
        #expect(url?.absoluteString == "https://mla-s1-p.mlstatic.com/980849-MLA31002261498_062019-I.jpg")
    }

    @Test func getDiscountPercentage() {
        // Given
        let originalPrice: Double = 100000
        let newPrice: Double = 70000
        let expectedDiscount = "30 %"
        // When
        let discount = MeliUtils.getDiscountPercentage(originalPrice: originalPrice, newPrice: newPrice)
        // Then
        XCTAssertEqual(discount, expectedDiscount)
    }

    @Test func getDiscountPercentageWithoutOriginalPrice() {
        // Given
        let newPrice: Double = 70000
        // When
        let discount = MeliUtils.getDiscountPercentage(originalPrice: nil, newPrice: newPrice)
        // Then
        #expect(discount == nil)
    }

    @Test func getDiscountPercentageWithOriginalPriceZero() {
        // Given
        let originalPrice: Double = .zero
        let newPrice: Double = 70000
        // When
        let discount = MeliUtils.getDiscountPercentage(originalPrice: originalPrice, newPrice: newPrice)
        // Then
        #expect(discount == nil)
    }
}
