import Foundation

public enum OneTimePasswordAPIRouter: BaseRouter {
    case getToken(msisdn: String, otp: String)
    
    public var host: String {
        switch self {
        case .getToken:
            return "staging-api-market.o.kg"
        }
    }
    
    public var path: String {
        switch self {
        case .getToken:
            return "/api/market-auth/check-otp/"
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
        case .getToken(let msisdn, let otp):
            let parameters: Parameters = [
                "msisdn": msisdn,
                "otp": otp
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
