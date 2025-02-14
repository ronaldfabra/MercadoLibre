//
//  QuestionEndpoint.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


enum QuestionEndpoint {
    case getQuestions(itemId: String, limit: Int, offset: Int)
}

extension QuestionEndpoint: EndPointProtocol {
    var baseUrl: String {
        MeliConstants.MeliURL.baseURL
    }

    var apiVersion: Int {
        MeliConstants.MeliURL.questionsApiVersion
    }

    var relativeURL: String {
        switch self {
        case .getQuestions:
            return "questions/search"
        }
    }

    var method: String {
        return URLRequestMethod.get.rawValue
    }

    var urlString: String {
        switch self {
        case .getQuestions:
            return "\(baseUrl)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
        case .getQuestions(let itemId, let limit, let offset):
            params[MeliConstants.MeliURL.Params.itemKey] = itemId
            params[MeliConstants.MeliURL.Params.limitKey] = limit
            params[MeliConstants.MeliURL.Params.offsetKey] = offset
            params[MeliConstants.MeliURL.Params.apiVersionKey] = apiVersion
        }
        return params
    }
}
