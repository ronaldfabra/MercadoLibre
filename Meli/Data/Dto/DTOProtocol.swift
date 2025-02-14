//
//  DTOProtocolDecodable.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


protocol DTOProtocolDecodable: Decodable & DomainModelable {}
protocol DTOProtocol: Codable & DomainModelable {}

protocol DomainModelable {
    associatedtype DomainModel

    func toDomain() throws -> DomainModel
}
