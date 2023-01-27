import Foundation

public enum MainAPIRouter: BaseRouter {
    case token(page: String?)
    
    public var host: String {
        switch self {
        case .token:
            return "staging-api-market.o.kg"
        }
    }
    
    public var path: String {
        switch self {
        case .token:
            return "/api/ads-board/v1/ads/list/"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .token:
            return .get
        }
    }
    
    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .token(let page):
            let queryItem: URLQueryItem = .init(name: "page", value: page)
            return [queryItem]
        }
    }
    
    public var httpBody: Data? {
        return nil
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .token:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }
    
    public var port: Int? {
        switch self {
        case .token:
            return nil
        }
    }
}


public enum CategoryAPIRouter: BaseRouter {
    case token
    
    public var host: String {
        switch self {
        case .token:
            return "staging-api-market.o.kg"
        }
    }
    
    public var path: String {
        switch self {
        case .token:
            return "/api/ads-board/v1/category/list"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .token:
            return .get
        }
    }
    
    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .token:
            return nil
        }
    }
    
    public var httpBody: Data? {
        return nil
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .token:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }
    
    public var port: Int? {
        switch self {
        case .token:
            return nil
        }
    }
}
