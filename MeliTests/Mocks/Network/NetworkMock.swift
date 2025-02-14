//
//  NetworkMock.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//


@testable import Meli

class NetworkMock<T: Decodable>: NetworkProtocol {

    var mockResponse: T? = nil

    func request<U: Decodable>(endPoint: EndPointProtocol, type _: U.Type) async throws -> U {
        if let mockResponse =  mockResponse as? U {
            return mockResponse
        } else {
            throw NetworkErrorType.invalidData
        }
    }
}
