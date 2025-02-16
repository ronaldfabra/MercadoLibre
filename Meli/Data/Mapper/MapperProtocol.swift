//
//  MapperProtocol.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

protocol MapperProtocol {
    associatedtype T
    associatedtype U
    func adapt(apiResponse: T) -> U
}
