//
//  ProductQuestionListFilterDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


struct ProductQuestionListFilterDto: DTOProtocol {
    let offset: Int
    
    func toDomain() -> ProductQuestionListFilterDomainModel {
        ProductQuestionListFilterAdapter().adapt(apiResponse: self)
    }
}
