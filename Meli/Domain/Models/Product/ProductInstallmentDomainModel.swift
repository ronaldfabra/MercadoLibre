//
//  ProductInstallmentDomainModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftData

@Model
final class ProductInstallmentDomainModel {
    @Attribute var quantity: Int
    @Attribute var amount: Double
    @Attribute var rate: Double
    
    init(quantity: Int, amount: Double, rate: Double) {
        self.quantity = quantity
        self.amount = amount
        self.rate = rate
    }
}
