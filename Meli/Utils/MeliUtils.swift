//
//  MeliUtils.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import Foundation

class MeliUtils {
    static func getImageUrl(thumbnailId: String?, thumbnail: String, urlExtension: String) -> URL? {
        let updatedURL: String
        if let thumbnailId {
            updatedURL = String(
                format: "%@%@%@",
                MeliConstants.MeliURL.imageBaseURL,
                thumbnailId,
                urlExtension
            )
        } else {
            updatedURL = thumbnail.replacingOccurrences(of: "http://", with: "https://")
        }
        return URL(string: updatedURL)
    }

    static func getDiscountPercentage(originalPrice: Double?, newPrice: Double) -> String? {
        guard let originalPrice = originalPrice, originalPrice > 0 else {
            return nil
        }
        let discount = (100 - (newPrice * 100) / originalPrice)
        return discount.toPercentage
    }
}
