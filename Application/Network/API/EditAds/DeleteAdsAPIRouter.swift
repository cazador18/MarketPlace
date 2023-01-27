import Foundation
public enum DeleteAPIRouter: BaseRouter {
case deleteAds(uuid: String)
    public var host: String {
        switch self {
        case .deleteAds:
            return "staging-api-market.o.kg"
        }
    }
    public var path: String {
        switch self {
        case .deleteAds(let uuid):
            return "api/ads-board/v1/ads/\(uuid)/"
        }
    }
    public var method: HTTPMethod {
        switch self {
        case .deleteAds:
            return .delete
        }
    }
    
    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .deleteAds:
            return nil
        }
    }
    public var port: Int? {
        switch self {
        case .deleteAds:
            return nil
        }
    }
    
    public var httpBody: Data? {
        switch self {
        case .deleteAds:
            return nil
        }
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .deleteAds:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }
}
