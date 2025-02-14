//
//  SiteEndpoint.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 12/02/25.
//


enum SiteEndpoint {
    case getSites
}

extension SiteEndpoint: EndPointProtocol {
    var baseUrl: String {
        MeliConstants.MeliURL.baseURL
    }

    var relativeURL: String {
        switch self {
        case .getSites:
            return "/sites"
        }
    }

    var method: String {
        return URLRequestMethod.get.rawValue
    }

    var urlString: String {
        switch self {
        case .getSites:
            return "\(baseUrl)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        return [:]
    }
}
