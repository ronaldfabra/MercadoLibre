//
//  ProductShippingDomainModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftData

@Model
final class ProductShippingDomainModel {
    @Attribute var freeShipping: Bool

    init(freeShipping: Bool) {
        self.freeShipping = freeShipping
    }
}
