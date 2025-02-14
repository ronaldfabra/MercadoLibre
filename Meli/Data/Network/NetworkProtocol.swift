//
//  NetworkProtocol.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T
}
