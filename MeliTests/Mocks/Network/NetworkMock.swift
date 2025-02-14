//
//  NetworkMock.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 14/02/25.
//


@testable import Meli

class NetworkMock<T: Decodable>: NetworkProtocol {

    var mockResponse: T? = nil

    func request<T: Decodable>(endPoint: EndPointProtocol, type _: T.Type) async throws -> T {
        if let mockResponse =  mockResponse as? T {
            return mockResponse
        } else {
            throw NetworkErrorType.invalidData
        }
    }
}
