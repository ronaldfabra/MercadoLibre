//
//  ProductPictureDomainModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//

import SwiftData

@Model
final class ProductPictureDomainModel {
    @Attribute var id: String
    @Attribute var secureUrl: String
    
    init(id: String, secureUrl: String) {
        self.id = id
        self.secureUrl = secureUrl
    }
}
