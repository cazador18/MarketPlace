import Foundation

public enum LoginAPIRouter: BaseRouter {
    case getToken(msisdn: String, password: String)
    
    public var host: String {
        switch self {
        case .getToken:
            return "staging-api-market.o.kg"
        }
    }
    
    public var path: String {
        switch self {
        case .getToken:
            return "/api/market-auth/auth/msisdn-password/"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getToken:
            return .post
        }
    }
    
    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .getToken:
            return nil
        }
    }
    
    public var httpBody: Data? {
        switch self {
        case .getToken(let msisdn, let password):
            let parameters: Parameters = [
                "msisdn": msisdn,
                "password": password
            ]
            
            let data = try? JSONParameterEncoder().encode(with: parameters)
            
            return data
        }
    }
    
    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .getToken:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }
    
    public var port: Int? {
        switch self {
        case .getToken:
            return nil
        }
    }
}
