//
//  ApiErrorDto.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


struct ApiErrorDto: Codable, Error {
    let error: String
    let message: String
    var code: Int?
}
