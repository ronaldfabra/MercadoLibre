//
//  ProductRow.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

struct ProductCell: View {

    var product: ProductDomainModel
    var isFavorite: Bool
    var isGrid: Bool = false
    var onFavoriteButtonTap: (() -> Void)?

    var body: some View {
        Group {
            if let imageUrl = product.thumbnailImageUrl {
                ZStack(alignment: .topTrailing) {
                    RemoteImageView(url: imageUrl)
                        .frame(width: MeliConstants.Dimens.productImageRowSize,
                               height: MeliConstants.Dimens.productImageRowSize)
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                    FavoriteButton(isFavorite: isFavorite) {
                        onFavoriteButtonTap?()
                    }
                    .font(.system(size: MeliConstants.Values.value14))
                }
            }
            VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing8) {
                primaryInformation
                priceInformation
                if product.shipping.freeShipping {
                    Text(MeliConstants.Strings.freeShipping)
                        .font(.system(size: MeliConstants.Values.value12,
                                      weight: .medium))
                        .foregroundColor(.green)
                }
            }
            .multilineTextAlignment(.leading)
        }
        .if(isGrid) { view in
            VStack(spacing: MeliConstants.Dimens.spacing8) {
                view
            }
        }
        .if(!isGrid) { view in
            HStack(alignment: .top, spacing: MeliConstants.Dimens.spacing8) {
                view
            }
        }
    }
}

// MARK: primaryInformation
extension ProductCell {
    var primaryInformation: some View {
        VStack(alignment: .leading, spacing: .zero) {
            if let brand = product.brand {
                Text(brand.uppercased())
                    .font(
                        .system(
                            size: MeliConstants.Values.value14,
                            weight: .bold
                        )
                    )
                    .foregroundColor(.black)
            }
            Text(product.title)
                .font(.system(size: MeliConstants.Values.value14,
                              weight: .regular))
                .foregroundColor(.black)
            if let storeName = product.officialStoreName {
                Text(String(format: MeliConstants.Strings.by, storeName))
                    .font(.system(size: MeliConstants.Values.value12,
                                  weight: .light))
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: primaryInformation
extension ProductCell {
    var priceInformation: some View {
        VStack(alignment: .leading, spacing: MeliConstants.Dimens.spacing8) {
            if let originalPrice = product.originalPrice,
               originalPrice > .zero,
               let originalPriceStr = originalPrice.toCurrency {
                Text(originalPriceStr)
                    .font(.system(size: MeliConstants.Values.value12,
                                  weight: .light))
                    .foregroundColor(.gray)
                    .strikethrough()
            }
            HStack(spacing: MeliConstants.Dimens.spacing10) {
                Text(product.price.toCurrency ?? .empty)
                    .font(.system(size: MeliConstants.Values.value18,
                                  weight: .medium))
                    .foregroundColor(.black)
                if let discountText = product.discountText {
                    Text(String(format: MeliConstants.Strings.discountOff, discountText))
                        .font(.system(size: MeliConstants.Values.value9,
                                      weight: .medium))
                        .foregroundColor(.green)
                }
            }
            if let installment = product.installments {
                Text(MeliConstants.Strings.in)
                    .font(.system(size: MeliConstants.Values.value12,
                                  weight: .regular))
                    .foregroundColor(.black)
                +
                Text(String(format: MeliConstants.Strings.installmentText,
                            installment.quantity,
                            installment.amount.toCurrency ?? .empty,
                            installment.rate.toPercentage ?? .empty)
                )
                .font(.system(size: MeliConstants.Values.value12,
                              weight: .regular))
                .foregroundColor(.green)
            }
        }
    }
}

#Preview {
    ProductCell(
        product: .init(
            id: "MLA1446313689",
            title: "Motorola Edge 50 Fusion 5g 256 Gb Ante Rosa 8 Gb Ram",
            seller: .init(id: 0, nickname: "MELI"),
            price: 1799900,
            condition: "new",
            permalink: "https://www.mercadolibre.com.ar/p/MLA12866684",
            thumbnail: "http://mla-s1-p.mlstatic.com/980849-MLA31002261498_062019-I.jpg",
            thumbnailId: "749220-MLA81161830115_122024",
            attributes: [.init(id: "BRAND", name: "Marca", value: "Motorola")],
            originalPrice: 2499000,
            installments: .init(quantity: 12, amount: 149992, rate: 0),
            officialStoreName: nil,
            shipping: .init(freeShipping: true),
            order: 1
        ),
        isFavorite: false
    )
}
