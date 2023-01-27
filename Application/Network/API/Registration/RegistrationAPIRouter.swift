import Foundation

public enum RegistrationAPIRouter: BaseRouter {
    case register(msisdn: String, password: String, password2: String)

    public var host: String {
        switch self {
        case .register:
            return "staging-api-market.o.kg"
        }
    }

    public var path: String {
        switch self {
        case .register:
            return "/api/market-auth/register/"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        }
    }

    public var queryParameter: [URLQueryItem]? {
        switch self {
        case .register:
            return nil
        }
    }

    public var httpBody: Data? {
        switch self {
        case .register(let msisdn, let password, let password2):
            let parameters: Parameters = [
                "msisdn": msisdn,
                "password": password,
                "password2": password2
            ]

            let data = try? JSONParameterEncoder().encode(with: parameters)

            return data
        }
    }

    public var httpHeaders: HTTPHeaders? {
        switch self {
        case .register:
            return ["x-api-key": "ypsGjpmpDR9GndA9YvzBHpIqXsFStfyq"]
        }
    }

    public var port: Int? {
        switch self {
        case .register:
            return nil
        }
    }
}
