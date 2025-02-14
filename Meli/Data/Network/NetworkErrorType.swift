//
//  NetworkErrorType.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import Foundation

enum NetworkErrorType: LocalizedError, Equatable {
    case invalidURL
    case invalidParams
    case invalidData
    case internetConnection
    case generalError
    case unkown(Error)
    case none
    
    static func == (lhs: NetworkErrorType, rhs: NetworkErrorType) -> Bool {
        lhs.errorDescription == rhs.errorDescription
    }
    
    var errorDescription: String {
        switch self {
        case .invalidURL: MeliConstants.Strings.NetworkError.invalidURL
        case .invalidParams: MeliConstants.Strings.NetworkError.serverError
        case .invalidData: MeliConstants.Strings.NetworkError.invalidData
        case .internetConnection: MeliConstants.Strings.NetworkError.internetConnection
        case .generalError: MeliConstants.Strings.NetworkError.general
        case .unkown(let error): error.localizedDescription
        case .none: .empty
        }
    }
    
    static func error(from error: ApiErrorDto) -> NetworkErrorType {
        switch error.code ?? .zero {
        case ResponseStatusType.notFound.rawValue: NetworkErrorType.invalidParams
        default: NetworkErrorType.unkown(error)
        }
    }
}
