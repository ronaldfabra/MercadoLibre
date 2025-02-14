//
//  SellerDomainModel.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftData

@Model
final class SellerDomainModel {
    @Attribute var id: Int
    @Attribute var nickname: String?
    
    init(id: Int, nickname: String?) {
        self.id = id
        self.nickname = nickname
    }
}
