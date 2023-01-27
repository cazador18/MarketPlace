import Foundation

public enum RefreshTokenRouter: BaseRouter {
    case refreshToken(refreshToken: String)
    
    public var host: String {
        switch self {
        case .refreshToken:
            return "staging-api-market.o.kg"
        }
    }

    public var path: String {
        switch self {
        case .refreshToken:
            return "/api/market-auth/refresh-token/"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .refreshToken:
            return .post
        }
    }

    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .refreshToken:
            return nil
        }
    }

    public var httpBody: Data? {
        switch self {
        case .refreshToken(let refreshToken):
            let parameters: Parameters = [
                "refresh_token": refreshToken
            ]

            let data = try? JSONParameterEncoder().encode(with: parameters)

            return data
        }
    }

    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .refreshToken:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }

    public var port: Int? {
        switch self {
        case .refreshToken:
            return nil
        }
    }
}
