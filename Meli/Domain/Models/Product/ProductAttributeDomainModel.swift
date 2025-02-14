//
//  ProductAttributeDomainModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftData

@Model
final class ProductAttributeDomainModel {
    @Attribute var id: String
    @Attribute var name: String?
    @Attribute var value: String?
    
    init(id: String, name: String?, value: String?) {
        self.id = id
        self.name = name
        self.value = value
    }
}
