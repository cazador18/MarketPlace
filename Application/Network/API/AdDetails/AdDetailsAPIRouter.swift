import Foundation

public enum AdDetailsAPIRouter: BaseRouter {
    case adDetails(uuid: String)

    public var host: String {
        switch self {
        case .adDetails:
            return "staging-api-market.o.kg"
        }
    }

    public var path: String {
        switch self {
        case .adDetails(let uuid):
            return "/api/ads-board/v1/ads/\(uuid)/"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .adDetails:
            return .get
        }
    }

    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .adDetails:
            return nil
        }
    }

    public var httpBody: Data? {
        return nil
    }

    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .adDetails:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }

    public var port: Int? {
        switch self {
        case .adDetails:
            return nil
        }
    }
}
