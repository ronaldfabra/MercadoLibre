//
//  ProductDomainModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import Foundation
import SwiftData

@Model
final class ProductDomainModel: Equatable {
    @Attribute var id: String
    @Attribute var title: String
    @Relationship var seller: SellerDomainModel?
    @Attribute var price: Double
    @Attribute var condition: String
    @Attribute var permalink: String
    @Attribute var thumbnail: String
    @Attribute var thumbnailId: String?
    @Relationship var attributes: [ProductAttributeDomainModel]
    @Attribute var originalPrice: Double?
    @Relationship var installments: ProductInstallmentDomainModel?
    @Attribute var officialStoreName: String?
    @Relationship var shipping: ProductShippingDomainModel
    @Attribute var order: Int
    @Relationship var pictures: [ProductPictureDomainModel]?
    @Attribute var productDescription: String?
    @Relationship var questions: [ProductQuestionDomainModel]?
    @Attribute var savedDate: Date?

    var brand: String? {
        attributes
            .first(where: { $0.id == MeliConstants.Strings.brandId })?.value
    }

    var thumbnailImageUrl: URL? {
        MeliUtils
            .getImageUrl(
                thumbnailId: thumbnailId,
                thumbnail: thumbnail,
                urlExtension: MeliConstants.MeliURL.thumnailImageUrlExtension
            )
    }

    var defaultImageUrl: URL? {
        MeliUtils
            .getImageUrl(
                thumbnailId: thumbnailId,
                thumbnail: thumbnail,
                urlExtension: MeliConstants.MeliURL.originalImageUrlExtension
            )
    }

    var discountText: String? {
        MeliUtils.getDiscountPercentage(originalPrice: originalPrice, newPrice: price)
    }

    var imagesCarousel: [ProductPictureDomainModel] {
        pictures ?? [.init(id: thumbnailId ?? .empty, secureUrl: defaultImageUrl?.absoluteString ?? thumbnail)]
    }


    static func == (lhs: ProductDomainModel, rhs: ProductDomainModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.price == rhs.price &&
        lhs.condition == rhs.condition &&
        lhs.permalink == rhs.permalink &&
        lhs.thumbnailId == rhs.thumbnailId &&
        lhs.originalPrice == rhs.originalPrice &&
        lhs.officialStoreName == rhs.officialStoreName
    }

    init(
        id: String,
        title: String,
        seller: SellerDomainModel?,
        price: Double,
        condition: String,
        permalink: String,
        thumbnail: String,
        thumbnailId: String? = nil,
        attributes: [ProductAttributeDomainModel],
        originalPrice: Double? = nil,
        installments: ProductInstallmentDomainModel? = nil,
        officialStoreName: String? = nil,
        shipping: ProductShippingDomainModel,
        order: Int,
        pictures: [ProductPictureDomainModel]? = nil,
        productDescription: String? = nil,
        questions: [ProductQuestionDomainModel]? = nil,
        savedDate: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.seller = seller
        self.price = price
        self.condition = condition
        self.permalink = permalink
        self.thumbnail = thumbnail
        self.thumbnailId = thumbnailId
        self.attributes = attributes
        self.originalPrice = originalPrice
        self.installments = installments
        self.officialStoreName = officialStoreName
        self.shipping = shipping
        self.order = order
        self.pictures = pictures
        self.productDescription = productDescription
        self.questions = questions
        self.savedDate = savedDate
    }
}
