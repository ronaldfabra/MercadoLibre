//
//  ProductEndpoint.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//


enum ProductEndpoint {
    case search(siteId: String, query: String, limit: Int, offset: Int)
    case detail(id: String)
    case description(id: String)
}

extension ProductEndpoint: EndPointProtocol {
    var baseUrl: String {
        MeliConstants.MeliURL.baseURL
    }

    var relativeURL: String {
        switch self {
        case .search(let siteId, _, _, _):
            return "sites/\(siteId)/search"
        case .detail(let id):
            return "items/\(id)"
        case .description(let id):
            return "items/\(id)/description"
        }
    }

    var method: String {
        return URLRequestMethod.get.rawValue
    }

    var urlString: String {
        switch self {
        case .search, .detail, .description:
            return "\(baseUrl)/\(relativeURL)"
        }
    }

    var parameters: [String: Any] {
        var params: [String: Any] = [:]
        switch self {
        case .search(_, let query, let limit, let offset):
            params[MeliConstants.MeliURL.Params.queryKey] = query
            params[MeliConstants.MeliURL.Params.limitKey] = limit
            params[MeliConstants.MeliURL.Params.offsetKey] = offset
        default:
            break
        }
        return params
    }
}
