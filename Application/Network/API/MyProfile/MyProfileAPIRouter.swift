import Foundation

public enum MyProfileAPIRouter: BaseRouter {
    case getActiveAds(page: String?)
    case getDisabledAds(page: String?)
    
    public var host: String {
        switch self {
        default:
            return "staging-api-market.o.kg"
        }
    }

    public var path: String {
        switch self {
        default:
            return "/api/ads-board/v1/user/my-ads/"
        }
    }

    public var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }

    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .getActiveAds(let page):
            let queryItem: URLQueryItem = .init(name: "page", value: page)
            return [queryItem]
            
        case .getDisabledAds(let page):
            let queryItem: URLQueryItem = .init(name: "page", value: page)
            return [queryItem]
        }
    }

    public var httpBody: Data? {
        switch self {
        case .getActiveAds:
            let parameters: Parameters = [
                "statuses": ["active"]
            ]
            let data = try? JSONParameterEncoder().encode(with: parameters)

            return data
            
        case .getDisabledAds:
            let parameters: Parameters = [
                "statuses": ["moderate"]
            ]
            let data = try? JSONParameterEncoder().encode(with: parameters)

            return data
        }
    }

    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .getActiveAds:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        case .getDisabledAds:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }

    public var port: Int? {
        switch self {
        default:
            return nil
        }
    }
}
